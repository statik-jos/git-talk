#!/bin/bash

source functions.sh

createEmptyRepo repo
setupBase

echo | git flow feature finish --rebase ISSUE-1
echo | git flow feature finish --rebase ISSUE-2
echo | git flow feature finish --rebase ISSUE-3
