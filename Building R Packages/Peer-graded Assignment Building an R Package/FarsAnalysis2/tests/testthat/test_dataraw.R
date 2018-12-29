#test_that('.csv data files are available',{
#  testthat::expect_equal(list.files('inst/extdata),
#                         c("accident_2013.csv.bz2","accident_2014.csv.bz2",
#                           "accident_2015.csv.bz2"))
#})

library(FarsAnalysis2)
test_that("can read FARS report CSV files",{
  df <- fars_read(system.file("extdata","accident_2014.csv.bz2",package="FarsAnalysis2"))
  expect_is(df,"data.frame")
  expect_equal(nrow(df),30056)
})
