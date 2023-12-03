#!/bin/sh

workingDir=/home/bot/balancer
scriptName=mayer.py

cd "${workingDir}" || exit 1
find . -name "*.mid" -type f 2>/dev/null | while read -r file; do
  read -r pid instance <"${file}"
  if kill -0 "${pid}" 2>/dev/null; then
    echo "${instance}" is alive
  else
    echo resurrecting "${instance}"
    tmux has-session -t "${instance}" 2>/dev/null
    if [ $? -eq 1 ]; then
      tmux new -d -s "${instance}"
    fi
    sleep 2
    tmux send-keys -t "${instance}" C-z "${workingDir}/${scriptName} ${instance}" C-m
  fi
done
