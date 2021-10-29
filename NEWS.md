## er.helpers 1.3.2

* Updated read_from_datalake for versioning.

## er.helpers 1.3.1

* Updated get_metadata function.

## er.helpers 1.3.0

* Added add_unused_levels function to assist with fixing a plotly legend bug.

## er.helpers 1.2.9

* Added readr library to read_csv function in read_from_datalake.

## er.helpers 1.2.8

* Added nz_region sf object

## er.heleprs 1.2.7

* Removed _na_inf functions.

## er.helpers 1.2.6

* Updated read_csv_datalake to use readr::write_excel_csv, so that macrons are preserved.  

## er.helpers 1.2.5 

* Bug fix: updated ggplot functions per updates to simplevis.
* New feature: added a4 dimensions. 

## er.helpers 1.2.4 

* Bug fix: corrected ordering of y variable in ggplot hbar functions.

## er.helpers 1.2.3

* New feature: added ggplot hbar functions that work with x_na_inf for APS data.

## er.helpers 1.2.2

* New feature: added read_from_datalake, get_metadata and write_rds_datalake functions.

## er.helpers 1.2.1

* Bug fix: ungrouped output from gridify_mb_data, so that an sf object is returned.

## er.helpers 1.2.0

* New feature: updated NZTCS pals.

## er.helpers 1.1.9

* New feature: added 2 new pals.

## er.helpers 1.1.8

* New feature: expand gridify_mb_data function to support the gridifying of more than 1 linecode.

## er.helpers 1.1.7

* New feature: add gridify_mb_data function to create a grid from meshblock data.

## er.helpers 1.1.6

* Bug fix: fixed read_excel_datalake.

## er.helpers 1.1.5

* New feature: add an NZ hexagonal grid sf object.

## er.helpers 1.1.4

* New feature: added read_excel_datalake function.

## er.helpers 1.1.3

* New feature: added the sankey_build_data function to support networkD3 sankey charts.

## er.helpers 1.1.2

* Improvement: darkened the shade of grey in pal_point_trend3 and pal_point_trend5.

## er.helpers 1.1.1

* Bug fix: aggregation functions now return NA as expected when all values are missing. Even if it passes other requirements.

## er.helpers 1.1.0

* New feature: Added all palettes from simplevis, plus a signed square root trans function scales. 
* New feature: Added a signed square root transformation function scale. 

## er.helpers 1.0.1

* Improvement: Order of season levels changed such that the annual category goes before the other seasons. 

## er.helpers 1.0.0

* New feature: Added `linear_model()` as another option for trend estimation
* Breaking changes: The slope calculated using `sen_slope()` is now returned in a data frame with a column called "slope" instead of "sen_slope". This is for consistency with the slope calculated using `linear_model()`

## er.helpers 0.12.0

* New feature: Added `sum_with_criteria()` to collection of aggregation functions
* Bug fix: Fixed a bug in `aggregate_with_criteria()` that meant that the mean was calculated regardless of the function indicated

## er.helpers 0.11.3

* Bug fix: Fixed bug in precipitation functions that prevented them from being calculated properly.
* Improvement: `search_data_lake()` has been deprecated in favour of `search_datalake()` to be consistent with naming
* Improvement: `search_datalake()` now uses AND instead of OR when filtering keys. 
* Improvement: `search_datalake()` now returns a tibble
* Improvement: Using MIT License

## er.helpers 0.11.2

* Bug fix: Fix documentation warning generated when installing the package.
* Bug fix: Functions used to calculate rainfall indices use wet days only (days > 1mm precipitation by default). 
* Improvement: Deprecated`get_reference_rainfall()` and `rainfall_above_reference()` in favour of `get_reference_precipitation()` and `precipitation_above_reference()` in order to adopt WMO names.   

## er.helpers 0.11.1

* Improvement: We use exclusion criteria on missing values to calculate anoamliesS
* Bug fix: When aggregation criteria were equal to 1 it correctly assume they are given as proportions
* Improvement: Aggregation with criteria functions now have default values for maximum number of missing values and maximum number of consecutive missing values.

## er.helpers 0.11.0

* New feature: A set of functions (`aggragate_with_criteria()`) to calculate aggregations using criteria for missing data. 
* New feature: A function to print the range of a numeric vector in a "pretty way".

## er.helpers 0.10.6

* Bug fix: When searching for a key in the data lake it looks for it in all the keys, not the first 1000

## er.helpers 0.10.5

* Bug fix: Return a p-value of 0.5 when all values are tied in Mann-Kendall test

## er.helpers 0.10.4

* Bug fix: Corrected spelling of Sen's slope

## er.helpers 0.10.3

* Bug fix: Trend functions `sen_slope()` and `mann_kendall()` return their method regardless of wether the trend estimation is successful or not. 

## er.helpers 0.10.2

* Improvement: Trend functions `sen_slope()` and `mann_kendall()` return NA if there are NAs in the input data.

## er.helpers 0.10.1

* Bug fix: Correcting spelling of autumn in `order_season_levels()`

## er.helpers 0.10.0

* New feature: Added `order_season_levels()` to automatically order season as a factor for pretty plotting and data standarisation
* Bug fix: Corrected example that were not working in `round_preserve_sum()`

## er.helpers 0.9.1

* Bug fix: `er.helpers:::likelihood_terms` internal data was not being saved properly. 

## er.helpers 0.9.0

* New feature: Added `simplifY_likelihood_levels()` which collapses levels in likelihood category factors
* New feature: Added `round_preserve_sum()` which rounds a set of number while maintaining the total. Used, for example, so that rounded percentages still add to 100. 

## er.helpers 0.8.0

* New feature:Added `get_likelihood_category()` which given a probabiliy p it returns the term used to describe the category this probability belongs to. It also ensures the levels of the output are ordered appropietly.
* New feature:Added `order_likelihood_levels()` which orders the levels of a likelihood category factor
* New feature:Added the datasets `ipcc_likelihood_scale` and `statsnz_likelihood_scale` which contain the Intergovernmental Panel on Climate Change (IPCC) and the Stats NZ likelihood scales respectively
* Improvement: Started using automatic package testing before things get out of hand

## er.helpers 0.7.0

* New feature: Added functions to calculate rainfall intensity metrics

## er.helpers 0.6.0

* New feature: Added function to calculate annual anomalies

## er.helpers 0.5.1

* Improvement: Trend functions warn when number of values is small or when all values are tied in the data

## er.helpers 0.5.0

* New feature: Added function search for object keys in a data lake

## er.helpers 0.4.1

* Bug fix: Reading data frames with a rowname X1 column doesn't fail anymore

## er.helpers 0.4.0

* New feature: Added function to calculate trends using Sen's slope and Mann-Kendall test
* Improvement: When downloading a csv from the data lake remove the X1 column

## er.helpers 0.3.0

* New feature: Added function to calculate the season of a date-time

## er.helpers 0.2.1

* Improvement: Added contribution section to README
* Improvement: Improved documentation
* Improvement: Added CHANGELOG 

## er.helpers 0.2.0

* New feature: Retrieve any version of a csv in the data lake
* New feature: Check all the versions of an object in the data lake
* Improvement: Better documentation
* Improvement: Fix notes and warnings in package testing

## er.helpers 0.1.0

* Functions to read and write files from data lake
* Function to launch shiny app in the background
