#!/bin/bash

# Place this in the following directory:
# note: you will need to create an "App" directory
#### Sublime.app/Contents/Resources/App

if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

while getopts ":wtfvh-:" opt; do
  case "$opt" in
    -)
      case "${OPTARG}" in
        wait)
          WAIT=1
          ;;
        help|version)
          REDIRECT_STDERR=1
          EXPECT_OUTPUT=1
          ;;
        foreground|test)
          EXPECT_OUTPUT=1
          ;;
      esac
      ;;
    w)
      WAIT=1
      ;;
    h|v)
      REDIRECT_STDERR=1
      EXPECT_OUTPUT=1
      ;;
    f|t)
      EXPECT_OUTPUT=1
      ;;
  esac
done

if [ $REDIRECT_STDERR ]; then
  exec 2> /dev/null
fi

if [ $OS == 'Mac' ]; then
  sublime_APP_NAME=sublime.app

  if [ -z "${sublime_PATH}" ]; then
    # If sublime_PATH isnt set, check /Applications and then ~/Applications for sublime.app
    if [ -x "/Applications/$sublime_APP_NAME" ]; then
      sublime_PATH="/Applications"
    elif [ -x "$HOME/Applications/$sublime_APP_NAME" ]; then
      sublime_PATH="$HOME/Applications"
    else
      # We havent found an sublime.app, use spotlight to search for sublime
      sublime_PATH="$(mdfind "kMDItemCFBundleIdentifier == 'com.github.sublime'" | grep -v ShipIt | head -1 | xargs -0 dirname)"

      # Exit if sublime can't be found
      if [ ! -x "$sublime_PATH/$sublime_APP_NAME" ]; then
        echo "Cannot locate sublime.app, it is usually located in /Applications. Set the sublime_PATH environment variable to the directory containing sublime.app."
        exit 1
      fi
    fi
  fi

  if [ $EXPECT_OUTPUT ]; then
    "$sublime_PATH/$sublime_APP_NAME/Contents/MacOS/sublime" --executed-from="$(pwd)" --pid=$$ "$@"
    exit $?
  else
    open -a "$sublime_PATH/$sublime_APP_NAME" -n --args --executed-from="$(pwd)" --pid=$$ --path-environment="$PATH" "$@"
  fi
elif [ $OS == 'Linux' ]; then
  SCRIPT=$(readlink -f "$0")
  USR_DIRECTORY=$(readlink -f $(dirname $SCRIPT)/..)
  sublime_PATH="$USR_DIRECTORY/share/sublime/sublime"
  sublime_HOME="${sublime_HOME:-$HOME/.sublime}"

  mkdir -p "$sublime_HOME"

  : ${TMPDIR:=/tmp}

  [ -x "$sublime_PATH" ] || sublime_PATH="$TMPDIR/sublime-build/sublime/sublime"

  if [ $EXPECT_OUTPUT ]; then
    "$sublime_PATH" --executed-from="$(pwd)" --pid=$$ "$@"
    exit $?
  else
    (
    nohup "$sublime_PATH" --executed-from="$(pwd)" --pid=$$ "$@" > "$sublime_HOME/nohup.out" 2>&1
    if [ $? -ne 0 ]; then
      cat "$sublime_HOME/nohup.out"
      exit $?
    fi
    ) &
  fi
fi

# Exits this process when sublime is used as $EDITOR
on_die() {
  exit 0
}
trap 'on_die' SIGQUIT SIGTERM

# If the wait flag is set, don't exit this process until sublime tells it to.
if [ $WAIT ]; then
  while true; do
    sleep 1
  done
fi
