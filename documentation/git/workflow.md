# synoa's git workflow

## [1] New project

The starting point for every project is the **master** branch. And the first thing to do is to create the initial commit directly into the **master** to set the code base for every other developer in the project.

### Create the repository

* Create the project on GitHub (e.g. https://github.com/synoa/git.workflow)
* Clone the project into your development environment (e.g. ```git clone git@github.com:synoa/git.workflow.git```)
* Add the basic code for your project, for example install Magento or WordPress locally and add it to the **master** when you are done:
  
  ```bash
  # Add all files to the local master branch
  git add .
  
  # Commit the added files
  git commit -m 'Initial commit.'
  
  # Push local branch master to GitHub
  git push origin master
  ```

#### Hints

* Use **.gitignore** to ignore files that should not be inside the repository before you create your initial commit
* When you create a new project on GitHub you can choose one of the predefined **.gitignore** files for a specific programming language if you have no idea what to put inside it:
  ![GitHub predefined .gitignore](https://raw.githubusercontent.com/synoa/synoa.github.io/master/documentation/git/img/github_new_repo_predefined_gitignore.png)

---

### Create the review branch

The **master** is used to update the **production site**, so everything inside the **master** is tested and working. The **review** branch is used to test the developed features on a **staging site** (more about this later). For now, we just create the **review** branch once for every project as a branch of **master**:

```bash
# Update master
git checkout master
git pull origin master

# Create review from master
git checkout -b review master

# Push review to GitHub
git push origin review
```

---

### Prepare deployment

Use the following two steps for every system you use for your project (e.g. a **staging site** to test the developments and **production site** for the end users). 

#### Server

* Create a **repository** folder on your server
* Clone your repository into the **repository** folder
  
  ```bash
  git clone --bare https://github.com/<user>/<repositoryName>
  ```
* Create a file called `post-receive` inside the **hooks** folder (`repository/<repositoryName>/hooks`) and add the following content: 
  
  ```bash
  #!/bin/sh

  # Path to the bare git repo for the project
  repository_path=<repositoryPath>

  # Path to the project itself
  project_path=<projectPath>

  # Iterate over all branches (git push --all)
  while read oldrev newrev refname
  do
      # Get the name of the current branch 
      branch=$(git rev-parse --symbolic --abbrev-ref $refname)

      # Checkout <branchName>
      if [ "$branch" = "<branchName>" ]; then
        git --work-tree=$project_path --git-dir=$repository_path checkout -f <branchName>
      fi
  done
  ```
* Make the `post-receive` file executable
  
  ```bash
  chmod +x post-receive
  ```
  
#### Local

Add the bare repository from the server as a new remote to your local project
  
  ```bash
  git remote add <remoteName> ssh://<user>@<domain><remoteRepositoryPath>
  ```

#### Example

You have a project called **myAwesomeProject**:

##### Server

  ```bash
  #!/bin/sh

  # Path to the bare git repo for the project
  repository_path=/var/repository/myAwesomeProject.git

  # Path to the project itself
  project_path=/var/www/myAwesomeProject

  # Iterate over all branches (git push --all)
  while read oldrev newrev refname
  do
      # Get the name of the current branch 
      branch=$(git rev-parse --symbolic --abbrev-ref $refname)

      # Checkout master
      if [ "$branch" = "master" ]; then
        git --work-tree=$project_path --git-dir=$repository_path checkout -f master
      fi
  done
  ```
  
##### Local

```bash
git remote add staging ssh://timpietrusky@synoa.de/var/repository/myAwesomeProject.git
```
---

### Problems

Maybe you can not push to your new bare repo with error message like

```bash
bash: git-receive-pack: command not found
```

Make sure that the command git-receive-pack is in path. First check the path of the command

```bash
which git-receive-pack
```
Output:
```bash
<path/to/missing/command>git-receive-pack
```
This path should also be in the output of following line
```bash
ssh you@remotemachine echo \$PATH
```
Outputs paths seperated by an _:_
```bash
first/path:second/path:third/path
```
If path is not included add the missing path in _.bashrc_ file with
```bash
export PATH=<missing path>:$PATH
```

---

## [2] Start local development

### Create a new feature

Create a new branch for every feature you want to develop, using the **master** branch as it's parent:

```bash
# Update master 
git checkout master
git pull origin master

# Create the feature branch from master
git checkout -b feat/<reference>/<featureName> master
```

* `<reference>` is the task from your management system (e.g. a bug tracker or resource planning) you create this feature for
* `<featureName>` is a user readable explanation for what this branch is about

#### Example

If you have a task with the id "1337" and you want to create a new function to delete the addresses of all customers, the branch could be named like this: 

```bash
git checkout -b feat/1337/deleteCustomerAddresses master
```

---

### See your changes

```bash
git status
```

---

### Add & commit your changes

When you are done developing your feature, you can commit your changes:

```bash
git add .
git commit -m 'My commit message'
```

---

### Revert a change

```bash
git checkout -- <changedFile>
```

---

### Share the feature on GitHub

For now the branch you created is only avialable in your local repository, so if you want to share it with others you have to push it to the remote repository (which is hosted on GitHub):

```bash
git push origin feat/<reference>/<featureName>
```

---

## [3] Feature is ready for testing

Your feature is "almost" finished and you want others (e.g. colleagues or customers) to test it. This is when the [**review** branch](#create-the-review-branch) comes into play, because the **review** is used on the **staging site**.

```bash
# Update review
git checkout review
git pull origin review

# Merge feature into review
git merge --no-ff feat/<reference>/<featureName>

# Push review to GitHub
git push origin review

# Push review to staging site [@see #prepare-deployment]
git push staging review
```

---

## [4] Feature is ready to be released

Your feature was tested and the development is done, so you can merge it into the **release** branch. 

### Create the release branch

The **release** branch has to be created if it doesn't exist yet. If there is a **release** branch already, you can skip this section.

```bash
# Update master
git checkout master
git pull origin master

# Create release from master
git checkout -b release master

# Push release to GitHub
git push origin release
```

A release consists of 1 or more feature branches and will be deleted once it's merged with the **master**. 

### Merge feature into release

```bash
# Update release
git checkout release
git pull origin release

# Merge feature into release
git merge --no-ff feat/<reference>/<featureName>

# Push release to GitHub
git push origin release
```

### Delete feature branch

After merging the feature into the release, you don't need the feature anymore and you can delete it: 

```bash
# Delete branch locally
git branch -d feat/<reference>/<featureName>

# Delete branch on GitHub
git push origin :feat/<reference>/<featureName>
```

---

## [5] Feature has a bug

If you find a bug in one of the features that is ready to be released and the feature was already deleted, you create a bugfix branch from **release** to fix the bug:

```bash
# Update release
git checkout release
git pull origin release

# Create bug branch from release
git checkout -b bug/<reference>/<bugName> release
```

If you want to test your fix you merge your bug branch back into **review** so that it can be tested on the **staging site**: [[3] Feature is ready for testing](#3-feature-is-ready-for-testing)

If you want to update your **production site** your bug branch has to be merged into the **release**: [Merge feature into release](#merge-feature-into-release)

---

## [6] Release is ready for production site

You have added all completed features to your **release** and want to update your **production site** with the content from **master**. 

```bash
# Update release branch
git checkout release
git pull origin release

# Update master branch
git checkout master
git pull origin master

# Merge release into master
git merge --no-ff release

# Get branches / tags from GitHub
git fetch origin --tags

# Check next tag version
git tag

# Add a tag for this release
git tag -a <tagName>

# Push the tag to GitHub
git push origin <tagName>

# Push master to GitHub
git push origin master

# Activate maintenance
magerun.phar sys:maintenance

# Create a SQL Dump
magerun.phar db:dump --compression="gzip"

# Move your sql dump out of doc root
mv <dumpname>.sql.gz ../../backups

# Push master to the production site [@see #prepare-deployment]
git push production master

# Run DB Update Scripts
magerun.phar sys:setup:run

# Clear Cache
magerun.phar cache:clean
magerun.phar cache:flush

# Build indexes
magerun.phar index:reindex:all

# Empty directories

rm -rf <magento_root>/var/cache/*
rm -rf <magento_root>/var/session/*

# Empty directory var/locks if it exists and not empty
rm -rf <magento_root>/var/locks/*

# Disable maintenance
magerun.phar sys:maintenance
```

### Test
Test your changes on live system

If everything is done you can delete your **release** branch because we don't need it anymore. 

```bash
# Delete release locally
git branch -d release

# Delete release on GitHub
git push origin :release
```

### Hint

* When you decide to update the **production site** you should inform everyone in your team with access to the **release** branch, that they are not allowed to merge any features / bug-fixes into the **release** that are not already merged into **release** branch while you are performing the update. 
