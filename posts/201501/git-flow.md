[source](http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/)
git flow init
git flow feature start featureName
git flow feature finish featureName
git flow release start 0.1.0
git flow release finish 0.1.0
git flow hotfix start hotfixName
git flow hotfix finish hotfixName



[source](http://nvie.com/posts/a-successful-git-branching-model/)

#start a new feature dev
git checkout -b myfeature develop
.... make every changes you want
//alias gac='git add . && git commit -m'
gac the feature done!

git checkout develop
git merge --no-ff myfeature
git branch -d myfeature
git push origin develop

#start a release
git checkout -b release-1.2 develop
./bump-version.sh 1.2
git commit -a -m "Bumped version number to 1.2"


git checkout master
git merge --no-ff release-1.2
git tag -a 1.2

git checkout develop
git merge --no-ff release-1.2

git branch -d release-1.2

#hotfix
git checkout -b hotfix-1.2.1 master
./bump-version.sh 1.2.1
git commit -a -m "Bumped version number to 1.2.1"
git commit -m "Fixed severe production problem"
git checkout master
git merge --no-ff hotfix-1.2.1
git tag -a 1.2.1
git checkout develop
git merge --no-ff hotfix-1.2.1
git branch -d hotfix-1.2.1