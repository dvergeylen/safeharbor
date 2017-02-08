#!/usr/bin/env bash

# Define credentials
GHUSER=YOUR_USERNAME
url="https://api.github.com/users/$GHUSER/starred"

# Loop while there is pagination
while [ ! -z "$url" ]
do
  # Fetch pagination
  output=$(curl -is "$url")
  repos=$(echo "$output" | grep "html_url" | grep -P '\S+\s"\K\S+' | cut -d'"' -f4)

  # For each result found, clone or update repo
  for repo in $repos; do
    if [[ "$repo" =~ http(s?)://github.com/(.+)/(.+) ]]
    then
      echo "Found Repository: $repo"
      dirname=$(echo "$repo" | cut -d"/" -f5)

      if [[ ! -d "$dirname" ]]; then
        git clone "$repo" # First time? Clone repo then
      fi

      # Keep all branches up-to-date
      cd "$dirname/"
      for b in $(git branch -r | grep -v -- '->'); do git branch --track ${b##origin/} $b; done
      git fetch --all
      cd "../"
    fi
  done

  # Find the next pagination URL
  url=$(echo "$output" | grep 'rel="next"' | cut -d';' -f1 | grep -Po "\<\K\S+" | tr -d '>')
done
