#!/bin/bash
cd "$(dirname "$0")"
cd ..

git fetch

# Get the name of the current branch
current_branch=$(git branch --show-current)

# Check if the current branch follows the naming pattern 'workYYYYMMDDHHMMSS'
if [[ $current_branch =~ ^work[0-9]{14}$ ]]; then
    # Extract the datetime part from the branch name
    datetime_part=${current_branch:4}

    # Construct the parent branch name
    parent_branch="main$datetime_part"

    # Check if the parent branch exists in the remote repository
    if git show-ref --verify --quiet "refs/remotes/origin/$parent_branch"; then
        # Parent branch exists, so create a pull request
        echo "Creating a pull request from $current_branch to $parent_branch..."
        gh pr create --base "$parent_branch" --head "$current_branch" --title "Pull Request from $current_branch to $parent_branch" --body "implemented additional GetDiscount requirements."
    else
        echo "Parent branch $parent_branch does not exist in the remote repository."
        exit 1
    fi
else
    echo "The current branch name does not follow the expected naming pattern."
    exit 1
fi
