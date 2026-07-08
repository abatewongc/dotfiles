#!/usr/bin/env python3
"""Prune git worktrees whose branches have been merged.

Lists every worktree with its PR status, defaults each to REMOVE or KEEP based on
the branch's GitHub PR state, lets you override any decision individually, then
removes the worktrees you confirm.

Merge detection uses the GitHub PR API (`gh`) rather than `git branch --merged`
because the repo squash-merges: a squashed branch tip is never an ancestor of the
target branch, so `--merged` would report it as unmerged.

Requires: git, gh (authenticated).

Written by Claude Opus.
"""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from dataclasses import dataclass, field
from typing import Optional

# PR states that mean "safe to remove" by default.
MERGED = "MERGED"
OPEN = "OPEN"
CLOSED = "CLOSED"

GREEN = "\033[32m"
YELLOW = "\033[33m"
RED = "\033[31m"
DIM = "\033[2m"
BOLD = "\033[1m"
RESET = "\033[0m"


@dataclass
class Worktree:
    path: str
    branch: Optional[str]  # short branch name, or None if detached
    head: str
    is_primary: bool = False
    pr_number: Optional[int] = None
    pr_state: Optional[str] = None
    pr_title: Optional[str] = None
    pr_url: Optional[str] = None
    remove: bool = False  # default decision, may be overridden
    reason: str = ""
    dirty: bool = field(default=False)


def run(cmd: list[str], cwd: Optional[str] = None) -> str:
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"`{' '.join(cmd)}` failed:\n{result.stderr.strip()}")
    return result.stdout


def parse_worktrees() -> list[Worktree]:
    """Parse `git worktree list --porcelain` into Worktree records."""
    out = run(["git", "worktree", "list", "--porcelain"])
    worktrees: list[Worktree] = []
    path = head = branch = None
    for line in out.splitlines() + [""]:  # trailing blank flushes last record
        if line.startswith("worktree "):
            path = line[len("worktree "):]
        elif line.startswith("HEAD "):
            head = line[len("HEAD "):]
        elif line.startswith("branch "):
            ref = line[len("branch "):]
            branch = ref.removeprefix("refs/heads/")
        elif line == "" and path is not None:
            worktrees.append(Worktree(path=path, branch=branch, head=head or ""))
            path = head = branch = None
    if worktrees:
        worktrees[0].is_primary = True  # first entry is the main working tree
    return worktrees


def is_dirty(path: str) -> bool:
    try:
        return bool(run(["git", "-C", path, "status", "--porcelain"]).strip())
    except RuntimeError:
        return False


def lookup_pr(branch: str) -> Optional[dict]:
    """Return the most relevant PR for a branch, preferring MERGED > OPEN > newest."""
    try:
        out = run([
            "gh", "pr", "list", "--head", branch, "--state", "all",
            "--json", "number,state,title,url", "--limit", "10",
        ])
    except RuntimeError:
        return None
    prs = json.loads(out or "[]")
    if not prs:
        return None
    priority = {MERGED: 0, OPEN: 1, CLOSED: 2}
    prs.sort(key=lambda p: (priority.get(p["state"], 3), -p["number"]))
    return prs[0]


def classify(wt: Worktree) -> None:
    """Set wt.remove and wt.reason based on its PR state."""
    if wt.is_primary:
        wt.remove, wt.reason = False, "primary working tree"
        return
    if wt.branch is None:
        wt.remove, wt.reason = False, "detached HEAD (no branch)"
        return
    pr = lookup_pr(wt.branch)
    if pr is None:
        wt.remove, wt.reason = False, "no PR found"
        return
    wt.pr_number = pr["number"]
    wt.pr_state = pr["state"]
    wt.pr_title = pr["title"]
    wt.pr_url = pr["url"]
    if pr["state"] == MERGED:
        wt.remove, wt.reason = True, f"PR #{pr['number']} MERGED"
    elif pr["state"] == OPEN:
        wt.remove, wt.reason = False, f"PR #{pr['number']} OPEN"
    else:
        wt.remove, wt.reason = False, f"PR #{pr['number']} CLOSED (not merged)"


def color_for(wt: Worktree) -> str:
    if wt.is_primary:
        return DIM
    if wt.remove:
        return RED
    if wt.pr_state == OPEN:
        return GREEN
    return YELLOW


def short(path: str) -> str:
    return path.rsplit("/", 1)[-1]


def print_table(worktrees: list[Worktree]) -> None:
    print(f"\n{BOLD}Worktrees{RESET}\n")
    for i, wt in enumerate(worktrees):
        c = color_for(wt)
        decision = f"{RED}REMOVE{RESET}" if wt.remove else f"{GREEN}KEEP{RESET}"
        if wt.is_primary:
            decision = f"{DIM}KEEP (primary){RESET}"
        dirty = f" {YELLOW}[uncommitted changes]{RESET}" if wt.dirty else ""
        branch = wt.branch or "(detached)"
        print(f"  {i:>2}  [{decision}]  {c}{short(wt.path)}{RESET}{dirty}")
        print(f"      {DIM}{branch} — {wt.reason}{RESET}")
        print(f"      {DIM}{wt.path}{RESET}")
        if wt.pr_url:
            print(f"      {DIM}{wt.pr_url}{RESET}")
    print()


def parse_indices(choice: str, count: int) -> list[int]:
    """Parse "1,3-5,7" into a sorted, de-duplicated list of valid indices.

    Raises ValueError on malformed tokens or out-of-range indices.
    """
    indices: set[int] = set()
    for token in choice.replace(" ", "").split(","):
        if not token:
            continue
        if "-" in token:
            lo_s, hi_s = token.split("-", 1)
            lo, hi = int(lo_s), int(hi_s)
            if lo > hi:
                lo, hi = hi, lo
            rng = range(lo, hi + 1)
        else:
            rng = range(int(token), int(token) + 1)
        for idx in rng:
            if idx < 0 or idx >= count:
                raise ValueError(f"index {idx} out of range")
            indices.add(idx)
    return sorted(indices)


def interactive_override(worktrees: list[Worktree]) -> None:
    overridable = [wt for wt in worktrees if not wt.is_primary]
    print(
        f"{DIM}Toggle decisions by number — single (3), comma list (1,4), or range (1-3). "
        f"'a' = remove all merged, 'n' = keep all, 'r' = reprint, 'd' = done.{RESET}"
    )
    while True:
        choice = input("override> ").strip().lower()
        if choice in ("d", "done", ""):
            return
        if choice in ("r", "reprint"):
            print_table(worktrees)
            continue
        if choice in ("n", "none"):
            for wt in overridable:
                wt.remove = False
            print_table(worktrees)
            continue
        if choice in ("a", "all"):
            for wt in overridable:
                wt.remove = wt.pr_state == MERGED
            print_table(worktrees)
            continue
        try:
            indices = parse_indices(choice, len(worktrees))
        except ValueError:
            print(f"{RED}Enter numbers (e.g. 1,3-5), 'a', 'n', 'r', or 'd'.{RESET}")
            continue
        for idx in indices:
            wt = worktrees[idx]
            if wt.is_primary:
                print(f"{RED}Cannot remove the primary working tree (skipped {idx}).{RESET}")
                continue
            wt.remove = not wt.remove
            print(f"  {short(wt.path)} -> {'REMOVE' if wt.remove else 'KEEP'}")


def remove_worktrees(worktrees: list[Worktree], force: bool, dry_run: bool) -> None:
    targets = [wt for wt in worktrees if wt.remove]
    if not targets:
        print("Nothing to remove.")
        return
    print(f"\n{BOLD}Removing {len(targets)} worktree(s):{RESET}")
    for wt in targets:
        cmd = ["git", "worktree", "remove"]
        if force:
            cmd.append("--force")
        cmd.append(wt.path)
        if dry_run:
            print(f"  {DIM}[dry-run]{RESET} {' '.join(cmd)}")
            continue
        try:
            run(cmd)
            print(f"  {GREEN}removed{RESET} {short(wt.path)}")
        except RuntimeError as e:
            msg = str(e)
            if "contains modified or untracked files" in msg and not force:
                print(f"  {YELLOW}skipped{RESET} {short(wt.path)} — dirty; rerun with --force")
            else:
                print(f"  {RED}failed{RESET} {short(wt.path)}: {msg.splitlines()[-1]}")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--dry-run", action="store_true", help="show actions without removing")
    ap.add_argument("--force", action="store_true", help="remove even with uncommitted changes")
    ap.add_argument("--yes", action="store_true", help="skip the interactive override step")
    args = ap.parse_args()

    try:
        worktrees = parse_worktrees()
    except RuntimeError as e:
        print(f"{RED}{e}{RESET}", file=sys.stderr)
        return 1

    print(f"Inspecting {len(worktrees)} worktrees (querying PR status)...")
    for wt in worktrees:
        classify(wt)
        if not wt.is_primary and wt.branch:
            wt.dirty = is_dirty(wt.path)

    print_table(worktrees)

    if not args.yes:
        interactive_override(worktrees)
        print_table(worktrees)

    targets = [wt for wt in worktrees if wt.remove]
    if targets and not args.dry_run:
        confirm = input(f"Remove {len(targets)} worktree(s)? [y/N] ").strip().lower()
        if confirm not in ("y", "yes"):
            print("Aborted.")
            return 0

    remove_worktrees(worktrees, force=args.force, dry_run=args.dry_run)
    return 0


if __name__ == "__main__":
    sys.exit(main())
