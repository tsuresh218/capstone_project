#!/bin/bash

# Variables
REPO_URL='https://github.com/tsuresh218/capstone_project.git'
LOCAL_DIRECTORY='/home/ubuntu/reactjs-demo'
REPO_DIRECTORY='/home/ubuntu/capstone_project'
NEW_BRANCH_NAME_1='dev'
DOCKERIGNORE_FILE='.dockerignore'
GITIGNORE_FILE='.gitignore'


# Clone the repo into your local directory
 git clone $REPO_URL

# Navigate to local directory
cd $LOCAL_DIRECTORY

# Copy the contents to local git repo
cp -R . $REPO_DIRECTORY

# Change to the cloned repository folder
cd $REPO_DIRECTORY

# Create a dev branch
git checkout -b $NEW_BRANCH_NAME_1
echo "New branch $NEW_BRANCH_NAME_1 was created"

# Check if .dockerignore exists
if [ -f "$DOCKERIGNORE_FILE" ]; then
    echo "$DOCKERIGNORE_FILE found"
else
    echo ".git
    *.md
    " > $DOCKERIGNORE_FILE
fi

# Check if .gitignore exists
if [ -f "$GITIGNORE_FILE" ]; then
    echo "$GITIGNORE_FILE found"
else
    echo ".DS_Store
    node_modules/
    dist/
    *.log
    " > $GITIGNORE_FILE
fi

# Add files to the local repository
git add .

# Commit your changes
git commit -m "Initial commit to include all the files to dev branch"

# Add remote repository
git remote add origin $REPO_URL

# Push the changes to dev branch on Github

if git push origin $NEW_BRANCH_NAME_1; then
    echo "Push to $NEW_BRANCH_NAME_1 branch was success"
else
    echo "Push to $NEW_BRANCH_NAME_1 branch was failed"
fi
