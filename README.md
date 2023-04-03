# worldriskpollr

The goal of this package is to provide you with easy, programmatic access to individual-level survey data from the World Risk Poll. The Lloyd's Register Foundation World Risk Poll provides us with the first ever complete picture of the differences between people's thoughts about, and experiences of risk. This insight will be used by regulators, businesses, governments and researchers to develop relevant and relatable policies that empower people to take action, that saves lives and help them feel safer.

Lloyd's Register Foundation teamed up with the Institute for Economics and Peace to examine the relationship between peace and perceptions of risk. This package was developed to enable further research on these important issues.

## Installation

The CRAN release version of `worldriskpollr` can be installed via:

``` r
install.packages("worldriskpollr")
```

You can install the most recent version from [GitHub](https://github.com/githubIEP/worldriskpollr/) with:

``` r
# install.packages("devtools")
devtools::install_github("githubIEP/worldriskpollr")
```

# Introduction

The World Risk Poll is the first ever global study of worry and risk across the world. The poll was conducted by Gallup as part of its World Poll, and is based on interviews with over 150,000 people, including those living in places where little or no official data exists, yet where reported risks are often high.

The World Risk Polls covers the biggest risks faced globally including new findings on subjects such as risks faced by women, safety of food, experience of serious injury and violence and harassment in the workplace, climate change, and online safety.

The poll will enable businesses, regulators, governments and academics to work with communities to develop policies and actions that save lives and make people feel safer. This landmark piece of research will be undertaken at least four times over eight years and the weight of knowledge accumulated will contribute in a more significant way than any past research, to making the world a safer place.

The poll reveals new insights -- for example demonstrating that demographic factors are generally a better predictor of risk perception than experience; and new findings that tell us how across the world, different groups of people experience risk in very different ways.

The poll highlights discrepancies between people's perception of risk and the actual likelihood of them experiencing those dangers. For the first time, we learn how safe people feel; how they perceive risk and what risks they experience everyday.

You can access more details and findings related to the World Risk poll [here](https://wrp.lrfoundation.org.uk/).

## Institute for Economics and Peace

Lloyd's Register teamed up with the Institute for Economics and Peace (IEP) to explore the complex relationship between peace and people's perceptions of risk and their safety and security. You can see our latest findings in the annual release of the Global Peace Index In June. Further information about IEP can be found [here](https://www.visionofhumanity.org/)).

IEP created this package to provide you with easy, programmatic access to the World Risk Poll. We are responsible for maintaining it. We encourage you to reach out to us directly if you have any questions about the package or our broader work measuring trends in peace and security.

## Country coverage

The World Risk Poll surveyed people in 150 countries in total, including countries with very low levels of peace where little or no official data exists, yet where reported risks are often high.

# Getting started

The `worldriskpollr` package is designed to give you quick and easy access to all data collected through the World Risk Poll. `worldriskpollr` provides you with an interactive package to interact and access aggregated survey data.

Using the following functions, it will download and process the World Risk Poll data into your package cache memory, then extract questions of interest.

## Search the World Risk Poll with `wrp_search`

To search for a question if interest, `worldriskpollr` provides `wrp_search` for users to enter a search term. If the search term is a match, `wrp_search` will return a data frame with the following columns.

-   `wrp_question_uid`: The unique identifier for the question, needed to use the function `wrp_get`.

-   `question`: The question in full.

-   `responses`: The responses given in the poll.

```{r, message = FALSE, warning = FALSE}
head(wrp_search("violence"))
```

## Getting aggregated World Risk Poll data using `wrp_get`

The `wrp_get` function provides users with a way of access aggregated data. The results are population weighted to the selected geography. Users can select which geographic region they would like to see the data at:

-   `country`: data is aggregated to the national level;

-   `region`: data is aggregated to the national level;

-   `income`: data is aggregated based on World Bank Income classification of the country.

-   `world`: data is aggregated to the global level.

The user also needs to select the desired disaggregation:

-   `0: No disaggregation`: aggregates to the selected geography;
-   `1: Age group`: respondent's age group;
-   `2: Sex`: respondent's sex;
-   `3: Education`: respondent's highest level of education;
-   `4: Income Feelings`: respondent's feelings about their household income;
-   `5: Income Quintiles`: respondent's per capita income quintile;
-   `6: Employment`: respondent's employment Status
-   `7: Residence`: respondent's residence: urban or rural;
-   `8: Household Size`: total number of people in the respondent's household;
-   `9: Children in Household`: total number of children under 15 in the respondent's household.

Users need to provide the desired aggregation level to `wrp_get` as a string. It is also necessary to provide a question code string, such as those provided returned in `wrp_search`. The use of `wrp_get` looks like:

```{r, message = FALSE, warning = FALSE}
head(wrp_get(geography = "country", wrp_question_uid = "Q1", disaggregation = 0))
```

This returns a 6 column dataframe in tidy format with the following columns:

-   `geography`: Lists the geography selected.

-   `disaggregation`: The disaggregation used in the data results.

-   `group`: the type of disaggregation

-   `year`: year of results

-   `question`: the question in full

-   `response`: the response

-   `percentage`: the percentage of respondents for each disaggregation that provided the relevant response.

# Standard Use Case

So a standard use case stringing `wrp_search` and `wrp_get` together could look like:

```{r, message = FALSE, warning = FALSE}
# Search for a topic
tmp <- wrp_search("violence")
# Pick the question of interest
tmp <- tmp[tmp$question ==
  "Ever Experienced Physical Violence/Harassment at Work (all countries)", ]
# Get the question code
tmp <- unique(tmp$wrp_question_uid)
# get the data
head(wrp_get(geography = "country", wrp_question_uid = tmp, disaggregation = 0))
```
