# synoa's git workflow

## Create the repository

The starting point for every project is the **master** branch. And the first thing to do is to create the initial commit directly into the **master** to set the code base for every other developer in the project.

### How to

* Create the project on GitHub (e.g. https://github.com/synoa/git.workflow)
* Clone the project into your development environment (e.g. ```git clone git@github.com:synoa/git.workflow.git```)
* Add the basic code for your project, for example install Magento or WordPress locally and add it to the **master** when you are done:
  
  ```
  git add .
  git commit -m 'Initial commit.'
  git push origin master
  ```

#### Hints

* Use **.gitignore** to ignore files that should not be inside the repository before you create your initial commit
* When you create a new project on GitHub you can choose one of the predefined **.gitignore** files for a specific programming language if you have no idea what to put inside it:
  ![GitHub predefined .gitignore](https://raw.githubusercontent.com/synoa/synoa.github.io/master/documentation/git/img/github_new_repo_predefined_gitignore.png)

## Create the review branch

The **master** is used to update the productive system, so everything inside the **master** is tested and working. The **review** branch is used to test the developed features on a test-system, but more about this later. For now, we just create the **review** branch once:

```
git checkout -b review master
git push origin review
```

---

## Start development

### Create a new feature

Create a new branch for every feature you want to develop, using the **master** branch as it's parent:

```
git checkout -b feat/<reference>/<featureName> master
```

* `<reference>` is the task from your management system (e.g. a bug tracker or resource planning) you create this feature for
* `<featureName>` is a user readable explanation for what this branch is about

#### Example

If you have a task with the id "1337" and you want to create a new feature to update customers, the branch would be named like this: `feat/1337/updateCustomers`


#### Commit your changes

When you are done developing your feature, you can commit your changes:

```
git add .
git commit -m 'My commit message'
```

#### Share the branch on GitHub

For now the branch you created is only avialable in your local repository, so if you want to share it with others you have to push it to the remote repository:

```
git push origin feat/<reference>/<featureName>
```

## Feature is ready for testing





