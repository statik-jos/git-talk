# git-talk
Glossary of git features I find useful.

## Slides
View the slides by opening 0-slides/index.html in a browser.
It's a [reveal.js](http://lab.hakim.se/reveal-js/) presentation.

## Demos
Below is a summary about each demo in the talk. These demos can be found in subdirs of this repository.  
The demos consist of a few shell scripts which create a git repository in the "repo" subdir of the demo dir.  
This repo dir can be explored with a git GUI or terminal commands.

### Demo 1: reflog and cursor branch
This demo shows the use of reflog to make lost commits accessible again.

Steps:
* remove one of the branches in the repo.
* use `git reflog` to get back the hash of the lost commit.
* use `git checkout <hash>` to change the HEAD to the lost commit.
* use `git branch` to make the commit show up in the log again, even when you're on another branch.  
  This last step is partly how a temporary or cursor branch can be used to keep access to otherwise lost commits.
 
### Demo 2: rebase vs merge
This demo shows why I prefer rebasing over merging.  
In short, the log looks more linear and is easier to read.  
I would keep merges for when there are merge conflicts which have forced a choice which could break stuff.

Most features can be added linearly, because they don't touch code the surrounding features touched.  
So, IMHO, there is no reason to put emphasis on the merging of two features for which it is impossible to have merge conflicts.

### Demo 3: prepend fix
This demo shows another use of rebase and also makes use of cherry-picking.

The story with this demo is:
* you've developed and released the "OldFeature" feature.
* you start developing the "NewFeature" feature.
* when you've made two commits for the new feature you come across a bug in the OldFeature.  
  This needs to be fixed ASAP and should be pushed to develop immediately, no time to wait for NewFeature to be completed.

Now I developed three different methods to accomplish this, with the cherry-pick and rebase combo resulting in the easiest way to realize and least cluttered log, IMHO.

### Demo 4: distributed rebase
This is where rebasing can create strange situations and can leave behind more of a mess than merging.  
But when all of the devs pushing to and pulling from the repo remember to rebase when pulling (option --rebase), these things should not happen.

There is even a setting in git to automatically rebase when pulling.  
To set this for your user account use:
````
git config --global pull.rebase true
````

The story with this demo is:
* there are three devs which are working in the same repo: Alice, Bob and Charlie.  
  Some are working on the same issue, some are developing issues on their own.  
  They push and pull to a shared repo on a server somewhere.
* at the start we see a repo with a feature for ISSUE-1 half finished, which Alice started and pushed so others can contribute.  
  Alice is quite busy and unable to continue development of the feature.
* meanwhile Bob gets the assignment to develop a feature for ISSUE-2.  
  This feature is developed quickly and is finished and pushed before the feature for ISSUE-1 is completed.
* development of ISSUE-1 has lingered long enough and Charlie gets the assignment of resuming development.
  She makes one commit, but hasn't pulled and does not see that Bob has pushed a finished feature on develop in the meantime.
* Alice returns to develop on this repository, she does a `git fetch` and sees Bob's feature.  
  She pulls in the new commits and decides to rebase her feature on top of the updated develop branch.  
  Rebasing went smoothly and, satisfied with the result, she decides to push the rebased feature branch to the origin.  
  This push is rejected by the local git binaries and results in an error. Git is a bit squeamish about non-fast forward pushes.  
  Long story short, use `git push --force` to get past this git restriction.
* Bob pulls changes from the origin remote.  
  By default git uses a merge strategy when pulling, this results in an automated merge of the old and rebased feature branches. Which is completely redundant, as there are no merge conflicts because the commits to merge are identical.  
  This makes the log less clear and harder to interpret, IMHO.
* if Bob used the rebase strategy when pulling, git would try to rebase the old feature branch on top of the new one instead of merging them.  
  This would results in the old commits being classified as duplicates, as there are identical commits on the new feature branch. These commits would be skipped.
* Charlie still hasn't seen the rebase and, to make things more complicated, Charlie has a commit on the old branch which needs to be relocated on top of the updated branch.
  By using the rebase strategy when pulling, the commits up to Charlie's commit are skipped, because they are classified as duplicates.  
  After that, Charlie's commit is rebased on top of the new feature branch.  
  So everything is ready for Charlie to continue developing the ISSUE-1 feature.

### Demo 5: feature inception
This is a feature in the git flow package.

When you are working on an issue with a big scope, it's sometimes a good idea to group certain functionality in a sub-feature.  
This can make it easier to interpret a large number of commits.

To do this, specify another feature branch as the base branch when creating a new feature branch:

````
git flow feature start ISSUE-1-1 feature/ISSUE-1
````

Git flow remembers this base branch and when using the `git flow finish` command the subfeature ISSUE-1-1 is merged in the ISSUE-1 feature branch instead of the default base branch (most repos use the "develop" branch for this).
