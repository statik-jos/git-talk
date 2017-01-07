#!/bin/bash

createRepoDir(){
	repoDir="$1"

	if ! [ -d "$repoDir" ]; then
		mkdir "$repoDir"
	fi

	find "$repoDir" -mindepth 1 -delete
}

createEmptyRepo(){
	repoDir="$1"

	createRepoDir "$repoDir"

	cd "$repoDir"
	git init
	git commit --allow-empty -m 'Initial commit'
	git branch develop
	git flow init --defaults
}

cloneRepo(){
	originDir="$1"
	repoDir="$2"

	createRepoDir "$repoDir"

	git clone "$originDir" "$repoDir"

	cd "$repoDir"
	git checkout develop
}
