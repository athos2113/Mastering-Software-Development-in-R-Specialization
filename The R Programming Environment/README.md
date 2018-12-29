# The R Programming Environment

This course provides a rigorous introduction to the R programming language, with a particular focus on using R for software development in a
data science setting. Whether you are part of a data science team or working
individually within a community of developers, this course will give you the
knowledge of R needed to make useful contributions in those settings.
As the first course in this specialization, the course provides the essential foundation
of R needed for the following coursess. We cover basic R concepts and
language fundamentals, key concepts like tidy data and related “tidyverse”
tools, processing and manipulation of complex and large datasets, handling
textual data, and basic data science tasks. Upon finishing this chapter, you
will have fluency at the R console and will be able to create tidy datasets from
a wide range of possible data sources.
The learning objectives for this chapter are to:

* Develop fluency in using R at the console
* Execute basic arithmetic operations
* Subset and index R objects
* Remove missing values from an R object
* Modify object attributes and metadata
* Describe differences in different R classes and data types
* Read tabular data into R and read in web data via web scraping tools
and APIs
* Define tidy data and to transform non-tidy data into tidy data
* Manipulate and transform a variety of data types, including dates, times,
and text data
* Describe how memory is used in R sessions to store R objects
* Read and manipulate large datasets
* Describe how to diagnose programming problems and to look up answers from the web or forum



# Swirl Assignments 

During this course we'll be using the swirl software package for R in order to illustrate some key
concepts. The swirl package turns the R console into an interactive learning environment.
Using swirl will also give you the opportunity to be completely immersed in an authentic R programming environment.

**1. Install R** : 
swirl requires R 3.1.0 or later. If you have an older version of R, please update before going any further.
If you're not sure what version of R you have, type R.version.string at the R prompt. 
You can download the latest version of R from (https://www.r-project.org/.)

Optional but highly recommended: Install RStudio.
You can download the latest version of RStudio at (https://www.rstudio.com/products/rstudio/.)

**2. Install Swirl** : 
Since swirl is an R package, you can easily install it by entering a single command from the R console:

```{r}
install.packages("swirl")
```

If you've installed swirl in the past make sure you have version 2.4.2 or later. You can check this with:
```{r}
packageVersion("swirl")
```

**Load swirl** :
Every time you want to use swirl, you need to first load the package. From the R console:

```{r}
library(swirl)
```

** Install the R Programming Environment course** :
swirl offers a variety of interactive courses, but for our purposes, you want the one called
The R Programming Environment. Type the following from the R prompt to install this course:

```{r}
install_course("The R Programming Environment")
```

**Start swirl and complete the lessons** :
Type the following from the R console to start swirl:
```{r}
swirl()
```


Then, follow the menus and select the R Programming Environment course 
when given the option. You'll need to complete all of the lessons below.

**Week 1**:
1. Setting Up Swirl
2. Basic Building Blocks
3. Sequences of Numbers
4. Vectors
5. Missing Values
6. Subsetting Vectors
7. Matrices and Data Frames
8. Logic
9. Workspace and Files

**Week 2**:
1. Reading Tabular Data
2. Looking at Data
3. Data Manipulation

**Week 3** :
1. Text Manipulation Functions
2. Regular Expressions
3. The stringr Package
