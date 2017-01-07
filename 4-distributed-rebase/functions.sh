#!/bin/bash

source ../functions.sh

setupBase(){
	createEmptyRepo origin && cd ..

	cloneRepo origin alice
		git config --local user.name 'Alice'
		git config --local user.email 'alice@statik.be'
	cd ..

	cloneRepo origin bob
		git config --local user.name 'Bob'
		git config --local user.email 'bob@statik.be'
	cd ..

	cloneRepo origin charlie
		git config --local user.name 'Charlie'
		git config --local user.email 'charlie@statik.be'
	cd ..
}

sharedFeature(){
	cd alice
		git flow feature start ISSUE-1

cat > Feature1.php <<HERE
<?php

class Feature1{
	public function method1(){
		echo 'Feature1::method1()', PHP_EOL;
	}
}
HERE

		git add Feature1.php
		git commit -m 'ISSUE-1 first commit'

		git push --set-upstream origin feature/ISSUE-1
	cd ..

	cd bob
		git fetch
		git checkout feature/ISSUE-1
	cd ..

	cd charlie
		git fetch
		git checkout feature/ISSUE-1
	cd ..
}

bobFeature2(){
	cd bob
		git flow feature start ISSUE-2
cat > Feature2.php <<HERE
<?php

class Feature2{
}
HERE

		git add Feature2.php
		git commit -m 'ISSUE-2 Added Feature2 class'

cat > Feature2.php <<HERE
<?php

class Feature2{
	public function method1(){
		echo 'Feature2::method1()', PHP_EOL;
	}
}
HERE

		git commit -a -m 'ISSUE-2 Added Feature2::method1() method'

		echo | git flow feature finish ISSUE-2

		git push
	cd ..
}

charlieFeature1Commit(){
	cd charlie
cat > Feature1.php <<HERE
<?php

class Feature1{
	public function method1(){
		echo 'Feature1::method1()', PHP_EOL;
	}

	public function method2(){
		echo 'Feature1::method2()', PHP_EOL;
	}
}
HERE

		git commit -a -m 'ISSUE-1 Added Feature1::method2() method'
	cd ..
}

aliceRebasePush(){
	cd alice
		git checkout develop
		git pull

		git checkout feature/ISSUE-1

		git rebase develop

		git push
	cd ..
}

aliceRebasePushForce(){
	cd alice
		git checkout develop
		git pull

		git checkout feature/ISSUE-1

		git rebase develop

		git push --force
	cd ..
}

bobPullMerge(){
	cd bob
		git checkout feature/ISSUE-1
		git fetch
		echo | git pull
	cd ..
}

bobPullRebase(){
	cd bob
		git checkout feature/ISSUE-1
		git fetch
		git pull --rebase
	cd ..
}

charliePullRebase(){
	cd charlie
		git fetch
		git pull --rebase
	cd ..
}
