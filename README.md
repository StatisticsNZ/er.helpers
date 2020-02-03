# er.helpers



## Installation

At the moment, to install this package you need to configure your [ssh access credentials](https://docs.gitlab.com/ee/ssh/) on [gitlabstats-prd](https://gitlabstats-prd). 

```r
# install.packages("remotes")
remotes::install_git("ssh://git@gitlabstats-prd/environmental-reporting/er.helpers.git", 
                     credentials = git2r::cred_ssh_key())
```

