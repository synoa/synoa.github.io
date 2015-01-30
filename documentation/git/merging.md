# Merging

When merging there are (basically) two ways of doing so, the first is the `git merge` command.

```
$ git merge <branch-1> <branch-2>
# <branch-2> is merged into <branch-1>
```

This way `<branch-2>` is merged into `<branch-1>` using the Fast Forward method which means combining the two working trees into one *without* doing a separated 
commit. This can become tricky when there was an error in `<branch-2>` that's now inside `<branch-1>`. This can be avoided, and simplified, by using the
`--no-ff` flag when merging. 

```
$ git merge <branch-1> <branch-2> --no-ff
```
This way both branches are still merged but git will also perform a commit, prompting a Commit/Merge message just as when you'd handle merge conflicts. This way
the merge has an explicit commit number and can be reverted in case of errors. With `git reflog <branch>` you can then view the latest commits and reset the
working tree to one of those commits - even if it was a merge. 

The GitHub Graph will also have more information because
every `--no-ff` commit still shows the branch one worked on before pushing to master.

### Make `--no-ff` default

Simply run `git config --global merge.ff false` inside a shell to set `--no-ff` merging to be the default.


### Resetting accidentally Fast-Forward merges

To reset an accidental Fast-Forward merge, use the following technique.

```
$ git reflog show master
# shows a table in the format
# COMMIT-NR BRANCH@{INDEX} - COMMIT-MSG
```
To revert changes use `git reset --keep` and the specific step, e.g. `git reset --keep master@{12}`. This will reset the master to a snapshot that lies in the
past. To revert accidental Fast-Forward merges use `git reset --keep master@{1}` (1 = last action before the accidental merge). 
