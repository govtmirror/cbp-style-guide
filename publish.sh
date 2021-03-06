#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

# Directory of Generated Files
cd cbp/style-guide

git init
git config user.name "David Hodge"
git config user.email "david.hodge@lucidtechnics.com"

git remote add upstream "https://$GH_TOKEN@github.com/US-CBP/cbp-style-guide.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages
