# CHANGELOG

## Version 0.10.6

* Bug fix: When searching for a key in the data lake it looks for it in all the keys, not the first 1000

## Version 0.10.5

* Bug fix: Return a p-value of 0.5 when all values are tied in Mann-Kendall test

## Version 0.10.4

* Bug fix: Corrected spelling of Sen's slope

## Version 0.10.3

* Bug fix: Trend functions `sen_slope()` and `mann_kendall()` return their method regardless of wether the trend estimation is successful or not. 

## Version 0.10.2

* Improvement: Trend functions `sen_slope()` and `mann_kendall()` return NA if there are NAs in the input data.

## Version 0.10.1

* Bug fix: Correcting spelling of autumn in `order_season_levels()`

## Version 0.10.0

* New feature: Added `order_season_levels()` to automatically order season as a factor for pretty plotting and data standarisation
* Bug fix: Corrected example that were not working in `round_preserve_sum()`

## Version 0.9.1

* Bug fix: `er.helpers:::likelihood_terms` internal data was not being saved properly. 

## Version 0.9.0

* New feature: Added `simplifY_likelihood_levels()` which collapses levels in likelihood category factors
* New feature: Added `round_preserve_sum()` which rounds a set of number while maintaining the total. Used, for example, so that rounded percentages still add to 100. 

## Version 0.8.0

* New feature:Added `get_likelihood_category()` which given a probabiliy p it returns the term used to describe the category this probability belongs to. It also ensures the levels of the output are ordered appropietly.
* New feature:Added `order_likelihood_levels()` which orders the levels of a likelihood category factor
* New feature:Added the datasets `ipcc_likelihood_scale` and `statsnz_likelihood_scale` which contain the Intergovernmental Panel on Climate Change (IPCC) and the Stats NZ likelihood scales respectively
* Improvement: Started using automatic package testing before things get out of hand

## Version 0.7.0

* New feature: Added functions to calculate rainfall intensity metrics

## Version 0.6.0

New features:

* Added function to calculate annual anomalies

## Version 0.5.1

Improvements:

* Trend functions warn when number of values is small or when all values are tied in the data

## Version 0.5.0

New features:

* Added function search for object keys in a data lake

## Version 0.4.1

Bug fixes:

* Reading data frames with a rowname X1 column doesn't fail anymore

## Version 0.4.0

New features:

* Added function to calculate trends using Sen's slope and Mann-Kendall test

Improvements:

* When downloading a csv from the data lake remove the X1 column

## Version 0.3.0

New features:

* Added function to calculate the season of a date-time

## Version 0.2.1

Improvements:

* Added contribution section to README
* Improved documentation
* Added CHANGELOG 

## Version 0.2.0

New features:

* Retrieve any version of a csv in the data lake
* Check all the versions of an object in the data lake

Improvements:

* Better documentation
* Fix notes and warnings in package testing

## Version 0.1.0

* Functions to read and write files from data lake
* Function to launch shiny app in the background
