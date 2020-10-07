#!/usr/bin/env bash

# Define usage
usage() { echo "Usage: GHUSER=myusername; $0 [--strict-mode] [-h|--help]" 1>&2; exit 1; }

# Define credentials
if [[ ! -v GHUSER ]]; then
  echo "No GHUSER env variable defined."
  usage
  exit 1
fi

url="https://api.github.com/users/$GHUSER/starred"
stars_list=()

# Parse Command Line
args=$(getopt -o h --longoptions help,strict-mode  -- "$@")

if [[ "${args[*]}" =~ "--help" || "${args[*]}" =~ "-h" ]]; then
  usage
fi

# #############################################
# Step 1: Clone and Update starred repositories
# #############################################
until test -z "$url"  # Loop while there is a pagination URL
do
  # Fetch pagination
  output=$(curl -is "$url")
  repos=$(echo "$output" | grep -P "html_url\": \"https://github.com/\S+/\S+" | cut -d '"' -f4)

  # For each result found, clone or update repo
  for repo in $repos; do
    dirname="${repo##https://github.com/}"
    echo "Found Repository: $dirname"
    dirname="${dirname/\//-}" # outputs: user-reponame

    if test ! -z "$dirname"; then

      if test ! -d "$dirname"; then
        git clone "$repo" "$dirname" # First time? Clone repo first
      fi

      # Keep all branches up-to-date
      pushd "$dirname"
      for b in $(git branch -r | grep -v -- '->'); do git branch --track "${b##origin/}" "$b"; done
      git fetch --all
      popd

      # Append Repo name prevent later removal
      stars_list+=("$dirname")
    fi
  done

  # Find the next pagination URL
  url=$(echo "$output" | grep -Po '<\S+>; rel="next"' | grep -Po "https\S+\d")
done

# ###############################################
# Step 2: Remove repositories not starred anymore
# ###############################################
if [[ "${args[*]}" =~ "--strict-mode" ]]; then
  repo_list=($(ls))
  diff_list=($(printf '%s\n' "${stars_list[@]}" "${repo_list[@]}" | sort | uniq -u))
  for dir in "${diff_list[@]}"; do
    rm -Rf "$dir"
  done
fi
