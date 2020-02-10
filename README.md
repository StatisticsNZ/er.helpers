# er.helpers

## Motivation

Some small tasks need to be carried out very often by Environmental Reporting team at Stats NZ; for example retrieving, cleaning, or publishing data or apps. Often, these small coding problems are solved multiple times in slightly different ways by different analysis/wranglers. To reuse the code, often files or lines are copy/pasted numerous times across the projects that need them. 

However, this is not very efficient. Furthermore, if we find an error in the code, it needs to be solved manually in all places where it has been copy/pasted. 

This package contains functions that help carry out common tasks in an easy way. Using the package has multiple benefits. First, we save time because tasks are solved only once, and solutions can be easily shared across analysts and projects without the need for copy/pasting. Second, it is easier to maintain code, because if a problem is found, only the code in the package needs to be maintained. Third, it makes code review (consistency checking) easier because packages come with conventions, and then we don't need to think multiple times about the best way to solve a problem.

## Installation

At the moment, to install this package you need to configure your [ssh access credentials](https://docs.gitlab.com/ee/ssh/) on [gitlabstats-prd](https://gitlabstats-prd). 

```r
# install.packages("remotes")
remotes::install_git("ssh://git@gitlabstats-prd/environmental-reporting/er.helpers.git", 
                     credentials = git2r::cred_ssh_key())
```

