##Advanced R Programming Assignment

######################################################################################################
#The objective of Part 1 is to write a function that computes the factorial of
#an integer greater than or equal to 0. Recall that the factorial of a number
#n is n * (n-1) * (n - 2) * . * 1. The factorial of 0 is defined to be 1. 

#For this Part you will need to write four different versions of the Factorial function:
#1. Factorial_loop: a version that computes the factorial of an integer using looping (such as a for loop)
#2. Factorial_reduce: a version that computes the factorial using the reduce() function
#   in the purrr package. Alternatively, you can use the Reduce() function in the base package.
#3. Factorial_func: a version that uses recursion to compute the factorial.
#4. Factorial_mem: a version that uses memoization to compute the factorial.
######################################################################################################

Factorial_loop <- function(x){
  factorial <- 1
  stopifnot(x >= 0)
  if(x == 0)
    1
  else(
    for(i in 1:x){
      factorial <- factorial * i
    }
  )
  print(factorial)
}

#############################################################

Factorial_reduce <- function(x){
  library(purrr)
  stopifnot(x >= 0)
  if(x == 0)
    1
  else(
    reduce(c(1:x), function(x,y){
      x*y
      
    })
    
  )
}


##########################################################################################

Factorial_func <- function(x){
  if(x == 0)
    1
  else if(x == 1)
    1
  else(
    return(x * Factorial_func(x - 1))
  )
}


###########################################################################################

Factorial_mem <- function(x) {
  fact_tabel <- c(rep(NA, x))
  if (x == 0) {
    return(1)
  } 
  fact_tabel[x] <- x * Factorial_mem(x-1)
  return(fact_tabel[x])
}


###########################################################################################

#After writing your four versions of the Factorial function, use the
#microbenchmark package to time the operation of these functions and 
#provide a summary of their performance. In addition to timing your functions
#for specific inputs, make sure to show a range of inputs in order to
#demonstrate the timing of each function for larger inputs.

library(microbenchmark)

microbenchmark(Factorial_loop(100), Factorial_reduce(100),
                                     Factorial_func(100), Factorial_mem(100))

microbenchmark(Factorial_loop(1000), Factorial_reduce(1000),
                                      Factorial_func(1000), Factorial_mem(1000))
