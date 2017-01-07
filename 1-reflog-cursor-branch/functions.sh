#!/bin/bash

source ../functions.sh

setupBase(){
	# ISSUE-1
	git flow feature start 'ISSUE-1'

cat > Feature1.php <<HERE
<?php

class KeepMe{
}

HERE

	git add Feature1.php
	git commit -m 'ISSUE-1 added KeepMe class.'

cat > Feature1.php <<HERE
<?php

class KeepMe{
	public function realDeal(){
		echo "This is the real deal", PHP_EOL;
	}
}

HERE

	git add Feature1.php
	git commit -m 'ISSUE-1 added the KeepMe::realDeal() method.'

	# ISSUE-2
	git flow feature start 'ISSUE-2'

cat > Feature2.php <<HERE
<?php

class Bogus{
}

HERE

	git add Feature2.php
	git commit -m 'ISSUE-2 herpaderp.'

cat > Feature2.php <<HERE
<?php

class Bogus{
	public function herpaderp(){
		echo "Lol wut?", PHP_EOL;
	}
}

HERE

	git add Feature2.php
	git commit -m 'ISSUE-2 lol wut?'
}
