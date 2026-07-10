#!/bin/sh

workingDir=/home/bot/balancer
scriptName=mayer.py
# virtual environment directory
venvDir=

set -e

resurrect() {
  instance=$1
  echo "resurrecting ${instance}"
  if ! tmux has-session -t "${instance}" 2>/dev/null; then
    tmux new -d -s "${instance}"
    sleep 1
  fi
  tmux send-keys -t "${instance}" C-z "python ${workingDir}/${scriptName} ${instance}" C-m
}

activate_venv() {
  [ -n "${venvDir}" ] && . "${venvDir}/bin/activate"
}

process_instances() {
  find . -name "*.mid" -type f 2>/dev/null | while read -r file; do
    read -r pid instance < "${file}"
    if ! (kill -0 "${pid}" 2>/dev/null && ps --pid "${pid}" -o comm= | grep -q "python"); then
      resurrect "${instance}"
    else
      echo "${instance} is alive"
    fi
  done
}

cd "${workingDir}" || exit 1
activate_venv
process_instances
