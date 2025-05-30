#!/bin/bash

HTPASSWD_FILE="./.htpasswd"

print_help() {
  echo "Usage: $0 [add|delete|list] username [password]"
  echo
  echo "Commands:"
  echo "  add <username> <password>     Add or update a user with bcrypt hash"
  echo "  delete <username>             Remove a user"
  echo "  list                          Show all usernames"
  exit 1
}

if [[ "$1" == "" ]]; then
  print_help
fi

command=$1
username=$2
password=$3

case $command in
  add)
    if [[ -z "$username" || -z "$password" ]]; then
      echo "Error: 'add' requires <username> and <password>"
      exit 1
    fi
    htpasswd -B -C 12 -b ${HTPASSWD_FILE} "$username" "$password"
    echo "User '$username' added/updated."
    ;;
  delete)
    if [[ -z "$username" ]]; then
      echo "Error: 'delete' requires <username>"
      exit 1
    fi
    htpasswd -D ${HTPASSWD_FILE} "$username"
    echo "User '$username' deleted."
    ;;
  list)
    if [[ ! -f ${HTPASSWD_FILE} ]]; then
      echo "No .htpasswd file found."
      exit 1
    fi
    echo "Users:"
    cut -d: -f1 ${HTPASSWD_FILE}
    ;;
  *)
    print_help
    ;;
esac
