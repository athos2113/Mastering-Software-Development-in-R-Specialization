# Building R Packages

This section covers building R packages. Writing good code for data science
is only part of the job. In order to maximize the usefulness and reusability of
data science software, code must be organized and distributed in a manner
that adheres to community-based standards and provides a good user experience. This section covers the primary means by which R software is organized
and distributed to others. We cover R package development, writing good
documentation and vignettes, writing robust software, cross-platform development, continuous integration tools, and distributing packages via CRAN
and GitHub. Learners will produce R packages that satisfy the criteria for
submission to CRAN.

The Learning objectives for this section are:

* Recognize the basic structure and purpose of an R package
* Create a simple R package skeleton using the devtools package
* Recognize the key directives in a NAMESPACE file
* Create R function documentation using roxygen2
* Create vignettes using knitr and R Markdown
* Create an R package that contains data (and associated documentation)
* Create unit tests for an R package using the testthat package
* Categorize errors in the R CMD check process
* Recall the principles of open source software
* Recall two open source licenses
* Create create a GitHub repository for an R package
* Create an R package that is tested and deployed on Travis
* Create an R package that is tested and deployed on Appveyor
* Recognize characteristics of R packages that are not cross-platform

# Before You Start
Building R packages requires a toolchain that must be in place before you
begin developing. If you are developing packages that contain only R code
then the tools you need come with R and RStudio. However, if you want to
build packages with compiled C, C++, or Fortran code (or which to build other
people’s packages with such code), then you will need to install additional
tools. Which tools you install depends on what platform you are running.


# Peer-graded Assignment: Documenting Code
>The purpose of this assessment is to document some R functions using roxygen2 style comments
that would eventually be translated into R documentation files. For this assignment you do NOT
need to build an entire package nor do you need to write any R code. You only need to document
the functions in the supplied R script.
The script containing the functions you need to document is here: [fars_function.R](https://d3c33hcgiwev3.cloudfront.net/_d4d3eb5980180587403780aa36de9f2c_fars_functions.R?Expires=1546300800&Signature=PTcUBWdRZgXdtPKWSJtkByJlxNK4ZSxz0qvB7R08KI9~3ZfsHAzAkkrlTtGL-kWmvjZiY5goAOdWyRYz7LNHdQkCrMwGrtXbhyZz2LBTXkqsJMy~FKJswy0mWdLGlE0kIqidCkvYS13OaEj2NqJyir8mb1rP1~EzxgE980X8ibw_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)

>The functions should be documented in the script file itself. Do not create a new script file.
Once you have written the documentation, you can upload the entire script file,
including the code and the documentation all together.

>The functions provided for you in this assignment will be using data from the US National Highway
Traffic Safety Administration's [Fatality Analysis Reporting System](http://www.nhtsa.gov/Data/Fatality-Analysis-Reporting-System-(FARS)), which is a nationwide
census providing the American public yearly data regarding fatal injuries suffered
in motor vehicle traffic crashes. You can download the data for this assignment here: [fars_data_zip](https://d3c33hcgiwev3.cloudfront.net/_e1adac2a5f05192dc8780f3944feec13_fars_data.zip?Expires=1546300800&Signature=byljyRPskWKpmmyUfzF1hMKln-IdQOoa4vCnVh82WqFBP4HgnTT~3kjr~XysTzFdVuS-6bTvLZ6V3b1jp3Cg4Gq797jTAGqK3NPfi1oRyDGm9MjBerNNIS8MiMcSJqFgInBXDxFXr-SOqFLE9GLUDNKoCPmb3qynYfZRV06FtQU_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A)


# Peer-graded Assignment: Building an R Package
>The purpose of this assessment is for you to combine your skills of creating,
writing, documenting, and testing an R package with releasing that
package on GitHub. In this assessment you'll be taking the R files
from Week 2's assessment about documentation and putting that file in an R package.

>For this assessment you must
1. write a vignette to include in your package using knitr and R Markdown
2. write at least one test written using testthat
3. put your package on GitHub
4. set up the repository so that the package can be checked and built on Travis
5. Once your package has built on Travis and the build is passing with no errors, warnings, or notes you should add your Travis badge to the README.md file of your package repository.
