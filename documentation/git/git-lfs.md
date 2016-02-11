# Git - Large File Storage

> Git Large File Storage (LFS) replaces large files such as audio samples, videos, datasets, and graphics with text pointers inside Git, while storing the file contents on a remote server like GitHub.com or GitHub Enterprise.

https://git-lfs.github.com/

## Getting Started

* Install with your favourite Package Manger or Download it from the [git-lfs Homepage](https://github.com/github/git-lfs/releases/).
* Open a Terminal and type ```git lfs install```
* Go to the Repository which should use *git lfs* and add the filetype to manage. e.G. ```git lfs track "*.jpg"```
* That's it! Commit and push as you normally would. In the normal *push* output you should see somthing like this: ```Git LFS: (1 of 1 files) 174.97 KB / 174.97 KB```
