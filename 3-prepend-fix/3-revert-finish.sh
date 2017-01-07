#!/bin/bash

source functions.sh

createEmptyRepo repo
setupBase

#REVERT AND MERGE
echo | git revert feature/ISSUE-2@{1}
echo | git revert feature/ISSUE-2@{3}

echo | git flow feature finish ISSUE-2

#RECREATE FEATURE
git flow feature start ISSUE-2

cat > "NewFeature.php" <<HERE
<?php

class NewFeature{
}
HERE

git add NewFeature.php

git commit -m "ISSUE-2 added new feature."

cat > "NewFeature.php" <<HERE
<?php

class NewFeature{
	public function doFeature(){
		echo 'NewFeature::doFeature()', PHP_EOL;
	}
}
HERE

git commit -a -m "ISSUE-2 added New::doFeature() method."

finishBase
