#!/bin/bash

source ../functions.sh

setupBase(){
	# FEATURE 1
	git flow feature start ISSUE-1

cat > "OldFeature.php" <<HERE
<?php

class OldFeature{
}
HERE

	git add OldFeature.php

	git commit -m "ISSUE-1 added old feature."

cat > "OldFeature.php" <<HERE
<?php

class OldFeature{
	public function doFeature(){
		echo 'OldFeature::doFeature()', PHP_EOL;
	}
}
HERE

	git commit -a -m "ISSUE-1 added OldFeature::doFeature() method."

	echo | git flow feature finish ISSUE-1

	# RELEASE 1.0.0
	git flow release start 1.0.0
	echo | git flow release finish -m '1.0.0' 1.0.0

	git checkout develop
	git merge master

	# FEATURE 2
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

cat > "OldFeature.php" <<HERE
<?php

class OldFeature{
	public function doFeature(){
		echo 'OldFeature::doFeature()', PHP_EOL;
		echo 'Fixed method',PHP_EOL;
	}
}
HERE

	git commit -a -m "ISSUE-2 fixed issue in OldFeature::doFeature() method."
}

finishBase(){
	echo | git flow feature finish ISSUE-2

	git flow release start 1.1.0
	echo | git flow release finish -m '1.1.0' 1.1.0

	git checkout develop
	git merge master
}
