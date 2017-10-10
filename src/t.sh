#!/usr/bin/env bash

# TODO: make this configurable
EDITOR="emacsclient -t"

function usage {
  echo "To edit task list directly: t -e"
  echo "To add a task to list: t <task description>"
  echo "To display task list: t"
  exit
}

# Check if ~/.t exists
if [ ! -d ~/.t ]; then
  mkdir ~/.t
  touch ~/.t/list.org
fi

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -h|--help)
      HELP=true
      shift
      ;;
    -e|--edit)
      EDIT=true
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done
set -- "${POSITIONAL[@]}"

if [ -n "$HELP" ]; then
  usage
fi

if [ -n "$EDIT" ]; then
  $EDITOR ~/.t/list.org
else
  if [ ${#POSITIONAL[@]} -eq 0 ]; then
    cat ~/.t/list.org
  else
    echo "* TODO: ${POSITIONAL[@]}" >> ~/.t/list.org
  fi
fi
