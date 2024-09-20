#!/bin/bash

current_branch=$(git rev-parse --abbrev-ref HEAD)

downstack_branch=$(git config branch.$current_branch.downstack-branch)

if [ -z "$downstack_branch" ]; then
  echo "No downstack branch configured for $current_branch"
  exit 1
fi

echo "Resetting $current_branch on top of $downstack_branch"

git reset --hard $downstack_branch