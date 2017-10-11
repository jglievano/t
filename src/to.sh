#!/usr/bin/env bash

# TODO: make this configurable
EDITOR="emacsclient -t"
TARGET="to.org"
KEYWORD="TO"
CMD="to"

function usage {
  echo "To edit task list directly: ${CMD} -e|--edit"
  echo "To add a task to list: ${CMD} <task description>"
  echo "To display task list: ${CMD}"
  echo "To sync: ${CMD} -s|--sync"
  exit
}

# Check if ~/.t exists
if [ ! -d ~/.t ]; then
  mkdir ~/.t
  touch ~/.t/to.org
  touch ~/.t/re.org
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
    -s|--sync)
      SYNC=true
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

if [ -n "$SYNC" ]; then
  cd ~/.t && git pull && git add . && git commit -m "auto" && git push
fi

if [ -n "$EDIT" ]; then
  $EDITOR ~/.t/${TARGET}
else
  if [ ${#POSITIONAL[@]} -eq 0 ]; then
    cat ~/.t/${TARGET}
  else
    echo "* ${KEYWORD}: ${POSITIONAL[@]}" >> ~/.t/${TARGET}
  fi
fi
