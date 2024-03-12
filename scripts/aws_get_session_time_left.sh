#!/bin/bash

# Use to find out IF "aws session expiration" exist AND compare the current system time to IT
# These are the expected result types we want to have:
# - "no aws session found" (NOTE: this does not mean there is no aws session open in another terminal)
# - how long until the session expires (for example +0h:59m:45s)
# - how long since the session expired (for example -49h:41m:12s)
# NOTE: the hours do not reset at every 24 hours, we do not require to display the days
# IMPORTANT: the date function arguments work on macOS, for other OS types may need adapting

if [[ $AWS_SESSION_EXPIRATION != '' ]]; then
  zulu_time_now="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" # TODO: see important note above

  aws_session_expiration_epoch="$(date -j -u -f '%Y-%m-%dT%H:%M:%SZ' $AWS_SESSION_EXPIRATION '+%s')" # TODO: see important note above
  zulu_time_now_epoch="$(date -j -u -f '%Y-%m-%dT%H:%M:%SZ' $zulu_time_now '+%s')"                   # TODO: see important note above

  if [[ $zulu_time_now < $AWS_SESSION_EXPIRATION ]]; then
    secs="$(expr $aws_session_expiration_epoch - $zulu_time_now_epoch)"
    echo "+$(printf '%dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60)))"
  else
    secs="$(expr $zulu_time_now_epoch - $aws_session_expiration_epoch)"
    echo "-$(printf '%dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60)))"
  fi
else
  echo "no aws session found"
fi