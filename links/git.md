[git-workflow-tutorial](https://github.com/xirong/my-git/blob/master/git-workflow-tutorial.md)
[source](https://www.atlassian.com/git/tutorials/comparing-workflows)

# centraized workflow
````
git pull --rebase origin master
# get some conflict
git add <some-file> 
git rebase --continue
# some conflict can not be resolove
git rebase --abort
# finally
git push
```

# feature branch workflow
```
git checkout -b marys-feature master
git status
git add <some-file>
git commit
git push -u origin marys-feature
# then others can discus about the new pull request
git checkout master
git pull
git pull origin marys-feature
git push
```

# gitflow workflow
```
git branch develop
git push -u origin develop
# other people only clone from origin develop
git clone ssh://user@host/path/to/repo.git
git checkout -b develop origin/develop
# working loop
git checkout -b some-feature develop
git status
git add <some-file>
git commit
# done with new feature
git pull origin develop
git checkout develop
git merge some-feature
git push
git branch -d some-feature
# start new release
git checkout -b release-0.1 develop
# developer at above can make test etc, for finally release
# now we finish fully test for production code, merge into master now
git checkout master
git merge release-0.1
git push
git checkout develop
git merge release-0.1
git push
git branch -d release-0.1
# make a tag for every release
git tag -a 0.1 -m "Initial public release" master
git push --tags
# user find online production code have a bug, developer hotfix it now
git checkout -b issue-#001 master
# Fix the bug
git checkout master
git merge issue-#001
git push
# merge the hotfix into develop branch
git checkout develop
git merge issue-#001
git push
git branch -d issue-#001

```
# forking workflow

