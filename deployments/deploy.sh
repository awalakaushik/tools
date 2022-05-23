#!/usr/bin/env sh

# abort on errors
set -e

# Checkout an orphan branch
# Docs: https://git-scm.com/docs/git-checkout/1.7.3.1#git-checkout---orphan
git checkout --orphan <your-orphan-branch-name>

# build
npm run build

# change directory to dist
cd dist
# add cname record for your subdomain
# for example: echo "www.testsite.com" > CNAME
echo "<your-website-subdomain>" > CNAME

# move to previous directory
cd -

# set worktree path to dist and stage all changes
# Docs: https://git-scm.com/docs/git#Documentation/git.txt---work-treeltpathgt
git --work-tree dist add --all

# set worktree path to dist and commit staged changes with a message
git --work-tree dist commit -m "Deploy"

# push committed changes to deployment origin branch
# For example: git push origin HEAD:deployment --force or git push origin HEAD:gh-pages --force
git push origin HEAD:<your-origin-branch-name> --force

# remove the dist folder
rm -rf dist

# checkout main
git checkout -f main

# delete orphan branch name
git branch -D <your-orphan-branch-name>
