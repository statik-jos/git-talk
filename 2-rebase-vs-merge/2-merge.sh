#!/bin/bash

source functions.sh

createEmptyRepo repo
setupBase

echo | git flow feature finish ISSUE-1
echo | git flow feature finish ISSUE-2
echo | git flow feature finish ISSUE-3
