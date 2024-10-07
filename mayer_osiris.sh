#!/bin/sh

workingDir=/home/bot/balancer
scriptName=mayer.py

resurrect() {
  instance=$1
  echo "resurrecting ${instance}"
  if ! tmux has-session -t "${instance}" 2>/dev/null; then
    tmux new -d -s "${instance}"
    sleep 1
  fi
  tmux send-keys -t "${instance}" C-z "${workingDir}/${scriptName} ${instance}" C-m
}

cd "${workingDir}" || exit 1
find . -name "*.mid" -type f 2>/dev/null | while read -r file;
do
  read -r pid instance <"${file}"
  if kill -0 "${pid}" 2>/dev/null; then
    processName=$(ps --pid "${pid}" -o comm h)
    if [ "${scriptName}" = "${processName}" ]; then
      echo "${instance} is alive"
      continue
    fi
  fi
  resurrect "${instance}"
done
