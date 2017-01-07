#!/bin/bash

source ../functions.sh

setupBase(){
for i in 1 2 3; do
	git flow feature start "ISSUE-$i"

cat > "Feature$i.php" <<HERE
<?php

class Feature${i}{
	public function method1(){
		echo 'Feature${i}::method1()', PHP_EOL;
	}
}
HERE

	git add "Feature$i.php"
	git commit -m "ISSUE-$i first commit"
done

for i in 1 2 3; do
	git checkout "feature/ISSUE-$i"

cat > "Feature$i.php" <<HERE
<?php

class Feature${i}{
	public function method1(){
		echo 'Feature${i}::method1() EDIT', PHP_EOL;
	}
}
HERE

	git add "Feature$i.php"
	git commit -m "ISSUE-$i second commit"
done
}
