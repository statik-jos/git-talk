#!/bin/bash

source functions.sh

createEmptyRepo repo
setupBase

#REPEAT FIX ON DEVELOP
git checkout develop

cat > "OldFeature.php" <<HERE
<?php

class OldFeature{
	public function doFeature(){
		echo 'OldFeature::doFeature()', PHP_EOL;

		echo 'Fixed method',PHP_EOL;
	}
}
HERE

git commit -a -m "Fix: fixed issue in OldFeature::doFeature() method."

echo | git flow feature finish ISSUE-2
