#!/bin/bash

# Variables
REPO_DIRECTORY='/mnt/c/Users/USER/Documents/capstone/capstone_reactjs'
NEW_BRANCH_NAME_1='master'


# Change to the cloned repository folder
cd $REPO_DIRECTORY

# Create a dev branch
git checkout --orphan $NEW_BRANCH_NAME_1
echo "New branch $NEW_BRANCH_NAME_1 was created"

# Remove the files
git rm -rf . > /dev/null 2>&1

# Commit your changes
git commit --allow-empty -m "Initial commit to master branch"

# Push the master branch on Github
if git push origin $NEW_BRANCH_NAME_1; then
    echo "Push to $NEW_BRANCH_NAME_1 branch was success"
else
    echo "Push to $NEW_BRANCH_NAME_1 branch was failed"
fi