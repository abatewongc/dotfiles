#!/bin/bash
# Create $os_default_name/<TICKET> branch off base (default: development), 
# then create a worktree for it and print the path (return)
# Usage: checkout_ticket.sh <ticket> [base-branch]
# Wrap in shell fn to cd: checkout_ticket() { cd "$(~/.dot/scripts/checkout_ticket.sh "$@")"; }

set -euo pipefail

ticket="${1:?ticket required (e.g. RAD-1234)}"
base_branch="${2:-development}"
my_name="${os_default_name:?os_default_name not set}"
branch_name="$my_name/$ticket"

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: not in a git repo" >&2
    exit 1
fi

if ! git show-ref --verify --quiet "refs/heads/$branch_name"; then
    git branch --no-track "$branch_name" "$base_branch"
fi

export WORKTREE_DIR="${os_worktree_dir:-/Users/christian/workspace/worktrees/openspace}"
create_worktree "$branch_name"