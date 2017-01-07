#!/bin/bash

source functions.sh

createEmptyRepo repo
setupBase

#GET FIX ON DEVELOP
git checkout develop

# cherry pick the fix (last commit in feature)
git cherry-pick feature/ISSUE-2

# and rewrite the commit message
git reset develop^ --soft
git commit -a -m 'Fix: fixed issue in OldFeature::doFeature() method.'

#SET FIX AS STARTING POINT FOR FEATURE
git checkout feature/ISSUE-2

# make old history easily accessible
git branch cursor

# rebase old feature on top of new history
git rebase develop

# delete old branch
git branch -D cursor
# you need to force this, because git sees this as an unmerged branch
# it's not aware we did some magic so we don't actually lose changes
# when this branch is deleted

finishBase
