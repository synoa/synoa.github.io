# synoa's git workflow

## Basic structure

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

#### Hint

* Use **.gitignore** to ignore files that should not be inside the repository before you create your initial commit
* When you create a new project on GitHub you can choose one of the predefined **.gitignore** files for a specific programming language if you have no idea what to put inside it:
  ![GitHub predefined .gitignore]()
