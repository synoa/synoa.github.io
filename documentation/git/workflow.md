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

The **master** is used to update the productive system, so everything inside the **master** is tested and working. The **review** branch is used to test the developed features on a test-system (more about this later). For now, we just create the **review** branch once for every project as a branch of **master**:

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

## [2] Start local development

### Create a new feature

Create a new branch for every feature you want to develop, using the **master** branch as it's parent:

```bash
git checkout -b feat/<reference>/<featureName> master
```

* `<reference>` is the task from your management system (e.g. a bug tracker or resource planning) you create this feature for
* `<featureName>` is a user readable explanation for what this branch is about

#### Example

If you have a task with the id "1337" and you want to create a new function to update the address of all customers, the branch could be named like this: 

```bash
git checkout -b feat/1337/updateCustomerAddress master
```


### Add & commit your changes

When you are done developing your feature, you can commit your changes:

```bash
git add .
git commit -m 'My commit message'
```

### Share the feature on GitHub

For now the branch you created is only avialable in your local repository, so if you want to share it with others you have to push it to the remote repository (which is hosted on GitHub):

```bash
git push origin feat/<reference>/<featureName>
```

---

## [3] Feature is ready for testing

Your feature is "almost" finished and you want others (e.g. colleagues or customers) to test it. This is when the **review** branch comes into play, because the **review** is used on the test-system.

```bash
# Update review
git checkout origin review
git pull origin review

# Merge feature into review
git merge --no-ff feat/<reference>/<featureName>

# Push review to GitHub
git push origin review

# Push review to test-system
git push staging review
```

---

## Feature is done

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

## Feature has a bug

If you find a bug in one of the features that is ready to be released and the feature was already deleted, you create a bugfix branch from **release** to fix the bug:

```bash
# Update release
git checkout release
git pull origin release

# Create bug branch from release
git checkout -b bug/<reference>/<bugName> release
```

If you want to test your fix you merge your bug branch back into **review** so that it can be tested on the test-system:

```bash
# Update review
git checkout review
git pull origin review

# Merge bug branch into review
git merge --no-ff bug/<reference>/<bugName>

# Push review to GitHub
git push origin review

# Push review to test-system
git push staging review
```

---

## Release is ready for productive system

You added all completed features to your **release** and want to update your productive system (**master**).  

```bash
# Update release branch
git checkout release
git pull origin release

# Update master branch
git checkout master
git pull origin master

# Merge release into master
git merge --no-ff release
# @TODO: add tags

# Push master to GitHub
git push origin master

# Push master to the productive system [a]
git push production master
```

## Deployment [a]

For now
