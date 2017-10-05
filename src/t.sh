#!/usr/bin/env bash

# Check if ~/.t exists
if [ ! -d ~/.t ]; then
  mkdir ~/.t
  touch ~/.t/list.org
fi

# Check if arguments passed. If so, input them to list. If not, display list.
if [ $# -eq 0 ]; then
  cat ~/.t/list.org
else
  echo "* TODO:" $@ >> ~/.t/list.org
fi
