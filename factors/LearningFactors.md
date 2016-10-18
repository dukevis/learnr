Factors and Analyzing Categorical Data
================

``` r
# Data downloaded from https://opendurham.nc.gov/explore/dataset/north_carolina_bicycle_crash_data_heatmap_/?tab=metas
# Data load code from http://www2.stat.duke.edu/~mc301/data/nc_bike_crash.html

bike <- read.csv("north_carolina_bicycle_crash_data_heatmap_.csv", 
                 sep = ";", stringsAsFactors = FALSE, na.strings = c("NA", "", ".", "/Missing"))
```

Factors in R
------------

Categorical, or discrete, variables can be either nominal (e.g., male/female) or ordinal (e.g., January/February/March/etc.). Most datasets have at least one categorical variable. Sometimes, the original dataset uses a numerical code that stands in for the name of a category (e.g., "1" for male and "2" for female), whether the categories have an inherent order or not. Other datasets may include the full category name, and if there is an inherent order it may be understandable to the human viewer but not by the computer.

In R, factors are a way of specifying some extra information about categorical variables that might be useful for data analysis or visualization. The primary information you might want to specify are **levels**, **labels**, and whether the factor should be considered **ordered**.

### Creating a factor

The basic process of creating a factor is sending a vector of values to the `factor()` command.

``` r
race <- factor(bike$Bike_Race)
summary(race)
```

    ##           Asian           Black        Hispanic Native American 
    ##              56            2006             297              67 
    ##           Other           White            NA's 
    ##              48            3111             131

If you try to look at the factor, it will print out just like the original data did, with one major exception. On your own, type just the name of the factor into the command line and hit enter.

``` r
race
```

You should see a list of every single data value in the factor, but you should also see a line at the end:

`Levels: Asian Black Hispanic Native American Other White`

So, what did the `factor()` command do? Well, first it went through the original data values and found all of the unique category names. (Note: if the data start out as numbers, `factor()` starts out by converting them to text with `as.character()`. Also, by default, `factor()` excludes "NA" from the list of levels.)

Since we didn't pass the function any additional information about these data, R doesn't know anything else about these particular values. Next, it sets the factor *levels* using the categories it found, placed in alphabetical order. This results in the list of levels we saw at the end of the list of data values.

For many categorical variables, this default behavior may be fine. If you know additional information about your data, however, it may be better to add levels or labels manually, or to specify that the levels are ordered. (For this reason, it is often a good idea to prevent R from converting character variables to factors on data import. Use the `stringsAsFactors = FALSE` option when reading csv files, etc.)

### Levels

You can specify any order for the levels; you don't have to be locked into alphabetical order. One reason you may want an alternative order for the levels is that the categories have a **natural order** -- for example, the months of the year.

``` r
# example from https://www.stat.berkeley.edu/classes/s133/factors.html

mons <- c("March","April","January","November","January","September","October","September",
         "November","August","January","November","November","February","May","August","July",
         "December","August","August","September","November","February","April")

mons.factor <- 
    factor(mons,
           levels=c("January","February","March","April",
                    "May","June","July","August",
                    "September","October","November","December"))
```

When you add the `levels` argument to the factor command, you pass it a vector of all of the categories, placed in the proper order. You can also set the levels on an existing factor by using the `levels()` command.

In the following example, the categories don't really have a natural order, but we might prefer that the "Other" category appears at the end. This is more of a *logical* order than a natural order.

``` r
race <- factor(bike$Bike_Race, levels = c("Asian","Black","Hispanic","Native American","White","Other"))

# You can check the levels by using levels() with the factor.

levels(race)
```

    ## [1] "Asian"           "Black"           "Hispanic"        "Native American"
    ## [5] "White"           "Other"

Another reason you might set levels is that there may be a difference in frequency of the different categories. Using frequency to order category is a **data-driven** (or just *useful*) order, and can make tables or visualizations based on this data more effective.

``` r
# This command takes a frequency table of the race categories, 
# sorts it in decreasing order, and then pulls out just the names, 
# which are used as the levels.

race <- factor(bike$Bike_Race, levels = names(sort(table(bike$Bike_Race),decreasing=TRUE)))

levels(race)
```

    ## [1] "White"           "Black"           "Hispanic"        "Native American"
    ## [5] "Asian"           "Other"

``` r
plot(race)
```

![](LearningFactors_files/figure-markdown_github/unnamed-chunk-6-1.png)

``` r
# If you don't believe this makes a difference, try plotting the original data.
# Isn't it much nicer in order?

barplot(table(bike$Bike_Race))
```

![](LearningFactors_files/figure-markdown_github/unnamed-chunk-6-2.png)

### Labels

Labels can be used if you want just want to rename the original category names. This is common when a number code is used for categories, but it can also come in handy with data values that start out as text.

``` r
mons.factor <- 
    factor(mons,
           levels=c("January","February","March","April",
                    "May","June","July","August",
                    "September","October","November","December"),
           labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

mons.factor
```

    ##  [1] Mar Apr Jan Nov Jan Sep Oct Sep Nov Aug Jan Nov Nov Feb May Aug Jul
    ## [18] Dec Aug Aug Sep Nov Feb Apr
    ## Levels: Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec

Note that even when you just type the name of the variable to view the data in the factor, the data values are displayed with the labels you have specified.

### Ordered

The `ordered` attribute can be specified as *TRUE* or *FALSE*. By default, it is set to FALSE. You may want to set the value to TRUE for variables that are truly ordinal - that is, when there is a natural ordering that is not dependent on the frequency of the category.

``` r
mons.factor <- 
    factor(mons,
           levels=c("January","February","March","April",
                    "May","June","July","August",
                    "September","October","November","December"),
           labels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
           ordered=TRUE)

mons.factor
```

    ##  [1] Mar Apr Jan Nov Jan Sep Oct Sep Nov Aug Jan Nov Nov Feb May Aug Jul
    ## [18] Dec Aug Aug Sep Nov Feb Apr
    ## 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec

Notice how the printing of the levels at the bottom uses "&lt;" to indicate that values on the left are "less than" values on the right. This isn't just a coincidence; you can actually compare categories with the "&lt;" operator.

``` r
mons.factor[1] < mons.factor[2] # Translates to "Mar < Apr"
```

    ## [1] TRUE

``` r
mons.factor[2] < mons.factor[3] # Translates to "Apr < Jan"
```

    ## [1] FALSE

``` r
race[7] < race[8] # Translates to "Black < Hispanic"
```

    ## Warning in Ops.factor(race[7], race[8]): '<' not meaningful for factors

    ## [1] NA

So, even if we have specified an order for the levels, it's not truly "ordered" unless you set `ordered = TRUE`. You can't use comparisons like "&lt;" on an unordered factor.

The order of the levels is useful for display in tables or charts, but you should only set it as an ordered factor if there is a natural ordering. That distinction may make a difference for certain types of analysis.

### When to use factors?

As we've said, factors are useful for tables and plot. In addition, some analysis functions like regressions actually do pay attention to factors. For example, when you use a factor as an independent variable for a regression, R knows to create [dummy variables](https://www.r-bloggers.com/data-types-part-3-factors/) of the categories. To learn more about using categorical variables in a regression analyis, you may enjoy this article on [contrast coding systems](http://www.ats.ucla.edu/stat/r/library/contrast_coding.htm).

Analyzing Categorical Data
--------------------------

The first step to analyzing categorical data is to establish how many observations are present in each category.

*Hat-tip to UCLA for the notes from its [Introductory R Class](http://statistics.ats.ucla.edu/stat/r/seminars/intro.htm).*

``` r
table(race)
```

    ## race
    ##           White           Black        Hispanic Native American 
    ##            3111            2006             297              67 
    ##           Asian           Other 
    ##              56              48

### Are my data evenly distributed across categories within one categorical variable?

Suppose you want to see if one of your categories is more frequent in your than you might expect based on the real world. For example, let's say you want to test if you have a fair coin, so you flip it a bunch of times and list out the results. To analyze a single categorical variable like this, you may want to perform a **Pearson's Chi-square Goodness of Fit** test. When you run a Chi-square test on a single variable, it will see if the distribution of data across the categories is equal (e.g., 50/50 for two categories, 33/33/33 for three categories). Alternately, if you know that in the real world your data should be divided 60/40, you can provide this information to the test. Then, the test will see if your data deviate from this known distribution.

### Summarizing two categorical variables

You can also cross-tabulate categorical data. A cross-tab is a table where you use one categorical variable for the rows and another for the columns, and then each cell displays the number of observations that are assigned both categories. This kind of table is also called a contingency table, which can also be used as an input to certain statistical tests.

``` r
race_by_injury <- xtabs(~ Bike_Race + Bike_Injur, data=bike)

race_by_injury
```

    ##                  Bike_Injur
    ## Bike_Race         A: Disabling Injury B: Evident Injury C: Possible Injury
    ##   Asian                             0                24                 29
    ##   Black                           100               705                932
    ##   Hispanic                         19               145                 97
    ##   Native American                   4                23                 29
    ##   Other                             5                14                 18
    ##   White                           163              1481               1084
    ##                  Bike_Injur
    ## Bike_Race         Injury K: Killed O: No Injury
    ##   Asian                1         0            2
    ##   Black               30        41          198
    ##   Hispanic             6         4           26
    ##   Native American      1         6            4
    ##   Other                1         0           10
    ##   White               37        72          274

### Are two categorical variables "correlated"?

One common statistical test that is applied to a cross-tab of two categorical variables is a **Pearson's Chi-square Test of Independence**. It's basically the same test mentioned above, but this time you apply it to two categorical variables. In a way, this measures whether there is some correlation or interaction between the two categorical variables. That is, it tests if the distribution of data across the categories of one variable is different for different categories of the other variable. *Note: This is the interpretation of someone not well trained in this area! Please take with a grain of salt!*

``` r
chisq.test(race_by_injury)
```

    ## Warning in chisq.test(race_by_injury): Chi-squared approximation may be
    ## incorrect

    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  race_by_injury
    ## X-squared = 135.32, df = 25, p-value < 2.2e-16

``` r
# Note: p-values are falling out of favor in science, 
# but typically you look for a p-value < 0.05, or even smaller.
```

An alternative test is **Fisher's exact test** (in R, `fisher.test`), which should be used instead of the chi-square test for small sample sizes. Of course, any of these test have basic assumptions that need to be met before you apply the test. (For example, the categories must not overlap; an observation should be assigned to only one category for each variable.) For details about these tests and their assumptions, see the **References** section below for introductory texts.

### How can I predict a binary outcome (e.g., spam/not spam) based on other measured variables?

This may be a job for **logistic regression**, a special kind of regression designed for an outcome variable that is not just categorical but specifically binary. Note: this method can be generalized to outcome variables that have more than two categories (multinomial logistic regression for nominal variables, ordinal logistic regression for ordered variables).

### Advanced: Do observations cluster nicely based on the categorical data values?

If you have observations that have been measured along a series of categorical variables, you may be interested in doing some kind of exploratory factor analysis. Some types of algorithms that look for patterns in large tables of data, like Principal Components Analysis (PCA), only work on numerical variables. To run a similar process on categorical data, it is not enough to change the categories into numbers. If they're really categories, pretending like they're numbers is only going to give you unreliable results.

Instead, you will use something like Correspondence Analysis or one of the types of factor analysis that allows for categorical data (e.g., Multiple Factor Analysis in FactoMineR). The MASS and FactoMineR packages in R offer many options.

References
----------

1.  [Introducing R](http://www.ats.ucla.edu/stat/r/seminars/intro.htm), Statistical Consulting Group, UCLA Institute for Digital Research & Education
2.  [R Learning Module - Factor variables](http://www.ats.ucla.edu/stat/r/modules/factor_variables.htm), Statistical Consulting Group, UCLA Institute for Digital Research & Education
3.  [What statistical analysis should I use?](http://www.ats.ucla.edu/stat/mult_pkg/whatstat/), Statistical Consulting Group, UCLA Institute for Digital Research & Education
4.  [OpenIntro Statistics](https://www.openintro.org/stat/textbook.php)
5.  An introduction to categorical data analysis, Alan Agresti ([Duke ebrary edition](http://search.library.duke.edu/search?id=DUKE005142588), [Duke EBL edition](http://search.library.duke.edu/search?id=DUKE005788503))
