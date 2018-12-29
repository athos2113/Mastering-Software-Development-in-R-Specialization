# Advanced R Programming

This course covers advanced topics in R programming that are necessary for
developing powerful, robust, and reusable data science tools. Topics covered
include functional programming in R, robust error handling, object oriented
programming, profiling and benchmarking, debugging, and proper design
of functions. Upon completing this course you will be able to identify and
abstract common data analysis tasks and to encapsulate them in user-facing
functions. Because every data science environment encounters unique data
challenges, there is always a need to develop custom software specific to
your organization’s mission. You will also be able to define new data types
in R and to develop a universe of functionality specific to those data types to
enable cleaner execution of data science tasks and stronger reusability within
a team

The learning objectives of the chapter are:
* Describe the control flow of an R program
* Write a function that abstracts a single concept/procedure
* Describe functional programming concepts
* Write functional programming code using the purrr package
* Manipulate R expressions to “compute on the language”
* Describe the semantics of R environments
* Implement exception handling routines in R functions
* Design and Implement a new S3, S4, or reference class with generics and
methods
* Apply debugging tools to identify bugs in R programs
* Apply profiling and timing tools to optimize R code
* Describe the principles of tidyverse functions

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
install_course("Advanced R Programming")
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
2. Functions

**Week 2**:
1. Functional Programming with purrr


**Week 4**:

## Peer-graded Assignment: Functional and Object-Oriented Programming ## :
The overall purpose of this assessment is to evaluate your ability to apply functional programming 
and object oriented programming concepts in R. There are two parts to this assignment. 
The first part compares different functional programming techniques and benchmarks their performance.
The second part uses object-oriented programming techniques to define a class to represent longitudinal data
and provide a set of functions for interacting with such data.

**Step-By-Step Assignment Instructions**:
>1. Part 1: Factorial Function :
>The objective of Part 1 is to write a function that computes the factorial of an integer greater
than or equal to 0. Recall that the factorial of a number n is n * (n-1) * (n - 2) * … * 1. The factorial of 0 is defined to be 1

>For this Part you will need to write four different versions of the Factorial function:
>**1. Factorial_loop**: a version that computes the factorial of an integer using looping (such as a for loop)
>**2. Factorial_reduce**: a version that computes the factorial using the reduce() function in the purrr package. Alternatively, you can use the Reduce() function in the base package.
>**3. Factorial_func**: a version that uses recursion to compute the factorial.
>**4. Factorial_mem**: a version that uses memoization to compute the factorial.

>After writing your four versions of the Factorial function, use the **microbenchmark package** to
>time the operation of these functions and provide a summary of their performance. 
>In addition to timing your functions for specific inputs, make sure to show a range of
>inputs in order to demonstrate the timing of each function for larger inputs.

>In order to submit this assignment, please prepare two files:
>**1. factorial_code.R**: an R script file that contains the code implementing your classes, methods, and generics for the longitudinal dataset.
>**2. factorial_output.txt**: a text file that contains the results of your comparison of the four different implementations.


>Part 2: Longitudinal Data Class and Methods :
>The purpose of this part is to create a new class for representing longitudinal data, which is data that is collected over time on a >given subject/person. This data may be collected at multiple visits, in multiple locations. You will need to write a series of generics >and methods for interacting with this kind of data.

>The data for this part come from a small study on indoor air pollution on 10 subjects. Each subject was visited 3 times for data >collection. Indoor air pollution was measured using a high-resolution monitor which records pollutant levels every 5 minutes and the >monitor was placed in the home for about 1 week. In addition to measuring pollutant levels in the bedroom, a separate monitor was >usually placed in another room in the house at roughly the same time.

[Click Here To Access the Data](https://github.com/athos2113/Mastering-Software-Development-in-R-Specialization/tree/master/Advanced%20R%20Programming/data)

>The variables in the dataset are
>id: the subject identification number
>visit: the visit number which can be 0, 1, or 2
>room: the room in which the monitor was placed
>value: the level of pollution in micrograms per cubic meter
>timepoint: the time point of the monitor value for a given visit/room
>You will need to design a class called **“LongitudinalData”** that characterizes the structure of this longitudinal dataset. You will >also need to design classes to represent the concept of a “subject”, a “visit”, and a “room”.

>In addition you will need to implement the following functions

>**make_LD**: a function that converts a data frame into a “LongitudinalData” object
>**subject: a generic function for extracting subject-specific information
>**visit**: a generic function for extracting visit-specific information
>**room**: a generic function for extracting room-specific information


>For each generic/class combination you will need to implement a method, although not all combinations are necessary (see below). You >will also need to write print and summary methods for some classes (again, see below).

>To complete this Part, you can use either the S3 system, the S4 system, or the reference class system to implement the necessary >functions. It is probably not wise to mix any of the systems together, but you should be able to compete the assignment using any of >the three systems. The amount of work required should be the same when using any of the systems.

For this assessment, you will need to implement the necessary functions to be able to execute the code in the following script file: **oop_output.R**

The output should appear similar to the output in the following file:
**oop_output.text**


In order to submit this assignment, please prepare two files:
**oop_code.R**: an R script file that contains the code implementing your classes, methods, and generics for the longitudinal dataset.
**oop_output.txt**: a text file containing the output of running the above input code.
