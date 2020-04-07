# er.helpers

Helper functions commonly used in Environmental Reporting at Stats NZ

## Motivation

Some small tasks need to be carried out very often by Environmental Reporting team at Stats NZ; for example retrieving, cleaning, or publishing data or apps. Often, these small coding problems are solved multiple times in slightly different ways by different analysis/wranglers. To reuse the code, often files or lines are copy/pasted numerous times across the projects that need them.

However, this is not very efficient. Furthermore, if we find an error in the code, it needs to be solved manually in all places where it has been copy/pasted. 

This package contains functions that help carry out common tasks in an easy way. Using the package has multiple benefits. First, we save time because tasks are solved only once, and solutions can be easily shared across analysts and projects without the need for copy/pasting. Second, it is easier to maintain code, because if a problem is found, only the code in the package needs to be maintained. Third, it makes code review (consistency checking) easier because packages come with conventions, and then we don't need to think multiple times about the best way to solve a problem.

## Installation

```r
# install.packages("remotes")
remotes::install_local("~/Network-Shares/U-Drive-SAS-03BAU/MEES/National Accounts/EnvReporting_Secure/rpackages/er.helpers/")
```

---

__Copyright and Licensing__

The package is Crown copyright (c) 2020, Statistics New Zealand on behalf of the New Zealand Government, and is licensed under the MIT License.

<br /><a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This document is Crown copyright (c) 2020, Statistics New Zealand on behalf of the New Zealand Government, and is licensed under the Creative Commons Attribution 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.