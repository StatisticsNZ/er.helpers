# er.helpers

Helper functions commonly used in Environmental Reporting at Stats NZ

## Motivation

Some small tasks need to be carried out very often by Environmental Reporting team at Stats NZ; for example retrieving, cleaning, or publishing data or apps. Often, these small coding problems are solved multiple times in slightly different ways by different analysis/wranglers. To reuse the code, often files or lines are copy/pasted numerous times across the projects that need them. 

However, this is not very efficient. Furthermore, if we find an error in the code, it needs to be solved manually in all places where it has been copy/pasted. 

This package contains functions that help carry out common tasks in an easy way. Using the package has multiple benefits. First, we save time because tasks are solved only once, and solutions can be easily shared across analysts and projects without the need for copy/pasting. Second, it is easier to maintain code, because if a problem is found, only the code in the package needs to be maintained. Third, it makes code review (consistency checking) easier because packages come with conventions, and then we don't need to think multiple times about the best way to solve a problem.

## Installation

At the moment, to install this package, you need to configure your [ssh access credentials](https://docs.gitlab.com/ee/ssh/) on [gitlabstats-prd](https://gitlabstats-prd). 

```r
# install.packages("remotes")
remotes::install_git("ssh://git@gitlabstats-prd/environmental-reporting/er.helpers.git", 
                     credentials = git2r::cred_ssh_key())
```

## Usage

To date, most of the functions are related to accessing the Ministry for the Environment data lake and publishing shiny apps. 

### MfE Data Lake

To read a csv file from the data lake just do:

```
library(er.helpers)
foo <- read_csv_datalake("path_of_file_in_data_lake.csv")
```

Credentials must be saved in "~/credentials.csv" for this to work. If you have them saved somewhere else use the function 

```
er.helpers::setup_datalake_access(cred_csv = "custom_path_to/credentials.csv")
``` 

To write a csv file to the data lake use:

```
write_csv_datalake(data_frame_in_environment, "path_of_file_in_data_lake.csv")
```

### Shiny apps

When running an app is often not possible to run code in the console. To launch an app and still be able to try out things and run code use:

```
launch_shiny_in_background(path = "app")
```
