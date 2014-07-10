Remember release process --

Code signing entity added is the one of the commit on this branch,  which is required to release app to the app store.

but this is not working when we want to test app on connected device, in that case, we need to revert the branch to previous commit before code signing entity,
-- for testing future release, created new branch which is releasetest1

To continue further dev, Plan:

1. clone from releasetest1 to new branch say X
Option 1
2. continue adding features to branch X -- then cherrypick the code signing part from branch releasetest
Option 2
3. merge branch releastest into branch X and then build, test and release to app store
