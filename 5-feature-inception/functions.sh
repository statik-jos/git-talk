#!/bin/bash

source ../functions.sh

doFeature(){
	featureId="$1"

	git flow feature start "ISSUE-1-${featureId}" "feature/ISSUE-1"

cat > "Feature${featureId}.php" <<HERE
<?php

class Feature${featureId}{
	public function method1(){
		echo 'Feature${featureId}::method1()', PHP_EOL;
	}
}
HERE

	git add "Feature${featureId}.php"
	git commit -m "ISSUE-1-${featureId} first commit"

cat > "Feature${featureId}.php" <<HERE
<?php

class Feature${featureId}{
	public function method1(){
		echo 'Feature${featureId}::method1() EDIT', PHP_EOL;
	}
}
HERE

	git add "Feature${featureId}.php"
	git commit -m "ISSUE-1-${featureId} second commit"

	echo | git flow feature finish "ISSUE-1-${featureId}"
}

setupBase(){
	git flow feature start "ISSUE-1"

	for i in 1 2 3; do
		doFeature $i
	done

	echo | git flow feature finish "ISSUE-1"
}
