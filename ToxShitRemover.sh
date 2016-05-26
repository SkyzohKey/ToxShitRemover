#!/bin/sh

# ToxShitRemover
# This script is intended to remove all the shit files produced by qTox.
# This is released under the MIT license, feel free to use, modify, and delete it.
#
# Special credits goes to Encrypt <https://github.com/Encrypt> and his script
# "toxdeb" that helped me a lot making this.

# Get execution arguments
readonly APPNAME=$(basename $0)
readonly ARGS=("$@")
readonly ARGS_NB=$#

# Internal script configuration
readonly TOX_DIR=~/.config/tox/
readonly SHIT_EXT=('*.fmetadata' '*.new.txt' '*.hash' '*.ini' '*.db' 'ricin.json')

main () {
  # Verify how many arguments get passed to the script.
  if [[ ${ARGS_NB} -lt 1 ]]
  then
    error 'arguments_number'
    return $?
  fi

  case ${ARGS[0]} in
    # Delete qTox shit files.
    --delete)
      echo -e ""
      echo -e "Tox folder is located at ${TOX_DIR}"
      echo -e "This procedure will wipe recursivly any shit files made by Tox clients."
      echo -e ""

      # Display a warning.
      tput bold; tput setaf 3;
      echo -e "-- WARNING! --"
      echo -e "This may delete files your Tox client uses/needs."
      echo -e "Be careful running this shell script."
      echo -e "-- WARNING! --"
      tput sgr0;

      read -p "Are you sure you want to proceed? [Y/n] " entry

      case $entry in
        Y)
          delete_shit
        ;;
        n)
          echo -e 'Abort.'
          return 0
        ;;
        *)
          error 'incorrect_entry' "$entry"
        ;;
      esac
    ;;

    # Display the help message
    --help)
      help
    ;;

    # Else, option not found, error.
    *)
      error 'unknown option' "${ARGS[0]}"
    ;;
  esac

  return $?
}

# Deletes shit from ${TOX_DIR} matching ${SHIT_EXT} files.
delete_shit () {
  echo -e ""

  for ext in "${SHIT_EXT[@]}"
  do
    echo -e "Removing ${ext} shit files..."
    cd ${TOX_DIR}
    find ${TOX_DIR} -iname "${ext}" -exec rm {} \;
  done

  echo -e ""
  echo -e "Cleanup finished. Exit."

  return 0
}

# Error handling.
error () {
  local error=$1
  echo -n 'Error: ' >&2

  case $error in
    # Arguments number was lower/higher than 1.
    arguments_number)
      echo -e "${APPNAME} expects 1 argument." >&2
      echo -e "Use --help to get further help." >&2
    ;;

    # Passed option is unknown.
    unknown_option)
      echo -e "Unknown option $2." >&2
      echo -e "Use --help to get further help." >&2
    ;;

    # Incorrect read entry passed.
    incorrect_entry)
      echo -e "Incorrect entry: $2. Abort." >&2
    ;;

    # Unknown error.
    *)
      echo -e "Unknown error: $error." >&2
    ;;
  esac

  return 1
}

# Help handling.
help () {
  cat <<-EOF
Usage: ${APPNAME} [option]

Options:
  --help    Display this help message.
  --delete  Delete Tox clients shit files.

License: This shell script is released under the MIT license.
EOF

  return 0
}

# Run the main function.
main

# Exit the correct code.
exit $?
