# er.helpers

### Introduction

`er.helpers` is an R package that facilitates the analysis and reporting of environmental indicators. 

We can group these helper functions into anomaly calculation, data aggregation, data acquisition, likelihood category estimation, precipitation indices, RShiny development, seasonality calculations, data summarisation and visualisation, and trend calculation.

* _Anomaly calculation:_ Functions to easily calculate anomalies of environmental indicators (e.g. temperature, rainfall, etc.
* _Data aggregation:_ Environmental statistics are often aggregated using missing data criteria agreed by international organisations. This package includes functions to aggregate (mean, sum, max, min, etc.) environmental data specifying a maximum number (or proportion) of missing data and a maximum number of consecutive missing data.
* _Data acquisition:_ Environmental data is often stored in cloud services like AWS S3. This package has wrapper functions to the aws.s3 R package to facilitate dataset retrieval and discovery. 
* _Likelihood estimation:_ Environmental reporting often involves communicating the likelihood of an event. This package contains functions to categorise the likelihood of a statistic based on its p-value. The categories are based on the IPCC categories and simplified versions used by Statistics NZ.
* _Precipitation:_ Functions to calculate some standard precipitation indices (precipitation from very wet days).
* _R Shiny_: Functions to facilitate the development of R Shiny applications.
* _Seasonality:_ A function to obtain the season of a date.
* _Summary and visualisation:_ A function to extract a range and format it to be used in plot labels. Functions to automatically order common environmental factors like seasons, likelihoods, and statistics. Functions to round percentages while maintaining their sum. 
* _Trends:_ Functions to calculate environmental trends (Sen's slope, Mann-Kendall test, and linear models).
* _Palettes:_ Colour palettes to be used for points, snz webpages or ea19 report images. 

### Installation

```r
# install.packages("remotes")
remotes::install_github("StatisticsNZ/er.helpers")
```

### Documentation

Webpage URL:

https://statisticsnz.github.io/er.helpers/

---

__Copyright and Licensing__

The package is Crown copyright (c) 2020, Statistics New Zealand on behalf of the New Zealand Government, and is licensed under the MIT License.

<br /><a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This document is Crown copyright (c) 2020, Statistics New Zealand on behalf of the New Zealand Government, and is licensed under the Creative Commons Attribution 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
