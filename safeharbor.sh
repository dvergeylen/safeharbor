#!/usr/bin/env bash

# Define credentials
GHUSER=GITHUB_USERNAME
url="https://api.github.com/users/$GHUSER/starred"
stars_list=()

# Define usage
usage() { echo "Usage: $0 [--strict-mode] [-h|--help]" 1>&2; exit 1; }

# Parse Command Line
args=$(getopt -o h --longoptions help  -- "$@")

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
  repos=$(echo "$output" | grep "html_url" | grep -P '\S+\s"\K\S+' | cut -d'"' -f4)

  # For each result found, clone or update repo
  for repo in $repos; do
    if [[ "$repo" =~ http(s?)://github.com/(.+)/(.+) ]]; then
      echo "Found Repository: $repo"
      dirname=$(echo "$repo" | cut -d"/" -f5)

      if test ! -z "$dirname"; then

        if test ! -d "$dirname"; then
          git clone "$repo" # First time? Clone repo first
        fi

        # Keep all branches up-to-date
        pushd "$dirname"
        for b in $(git branch -r | grep -v -- '->'); do git branch --track "${b##origin/}" "$b"; done
        git fetch --all
        popd

        # Append Repo name prevent later removal
        stars_list+=("$dirname")
      fi
    fi
  done

  # Find the next pagination URL
  url=$(echo "$output" | grep 'rel="next"' | cut -d';' -f1 | grep -Po "\<\K\S+" | tr -d '>')
done

# ###############################################
# Step 2: Remove repositories not starred anymore
# ###############################################
repo_list=($(ls))
diff_list=($(printf '%s\n' "${stars_list[@]}" "${repo_list[@]}" | sort | uniq -u))
for dir in "${diff_list[@]}"; do
  rm -Rf "$dir"
done
