#!/bin/bash
trap read debug

echo "Cleaning workdir"
trash-put ./*

# Checkout/create orphan branch (this branch won't show in git branch command)
echo "Creating orphan branch"
git checkout --orphan latest_branch
sleep .5

echo "Restoring CNAME"
cp ../CNAME .
sleep .5

echo "Copying coming soon index"
cp ../coming-soon-index.html index.html

# Add all the files to the newly created branch:
echo "Adding files to repo"
git add .
sleep .5

# Commit the changes
echo "Commiting change"
git commit -m "$(date)"
sleep .5

# Delete main (default) branch (this step is permanent):
echo "Deleting main"
git branch -D main
sleep .5

# Rename the current branch to main:
echo "Renaming orphan to main"
git branch -m main
sleep .5

# Finally, all changes are completed on your local repository, and force update your remote repository:
echo "Pushing change"
git push -f origin main

