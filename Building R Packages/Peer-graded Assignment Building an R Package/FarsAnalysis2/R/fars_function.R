#'-------------------------------------------------------------
#'COURSERA : BUILDING R PACKAGES
#'PEER REVIEW ASSIGNMENT
#'FILE : fars_function.R
#'SUBMITTED BY : JUNAID KHAN
#'
#'-------------------------------------------------------------
#'
#'\code{fars_read} : Read fars data
#'This function reads data from the US National Highway Traffic
#'Safety Administration's Fatality Analysis Reporting System.
#'The data provides us census regarding the American public yearly data
#'regarding fatal injuries sufferred in motor vehicle traffic crashes.
#'
#'@details For more information, see:
#' \itemize{
#'   \item{\url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}}
#'   \item{\url{https://en.wikipedia.org/wiki/Fatality_Analysis_Reporting_System}}
#'}
#'
#'@importFrom readr read_csv
#'@importFrom dplyr tbl_df
#'
#'@param filename A character string that takes the name of the
#'  file to read
#'@return A file that has read the csv data or an error stating
#'  that the data file does not exist
#'
#'@example
#'\dontrun{
#'   fars_read('data/filename.csv')
#'}
#'@export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}




#'\code{make_filename} : Read the input year and find the relevant
#' dataset for that year. If the approriate year is not written, the
#' sprintf function will return an error.
#'
#'@param year A numeric value of the year, used to find the relevant dataset
#'@return A character vector filename
#'
#'@example
#'\dontrun{
#'  make_filename(2014)
#'}
#'
#'@export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}


#'\code{fars_read_years} : Reads the year and finds the csv file matching
#' the same year. If the csv file is not found, 'invalid year' error is displayed.
#' if the year is appropriate,  the csv file is read and mutate a new column with
#' the year and then select the columns MONTH and year
#'
#'@importFrom dplyr mutate_
#'@importFrom dplyr select_
#'@importFrom magrittr "%>%"
#'
#'@param years A vector of year to be searched
#'@return A dataset with of the relevant year, with the columns MONTH and year.
#' Otherwise, an error 'invalid year' is displayed.
#'
#'@example
#'\dontrun{
#' fars_read_years(c(2013, 2014)
#'}
#'
#'@export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate_(dat, year = "year") %>%
        dplyr::select_("MONTH", "year")
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}



#'\code{fars_summarize_years} : The function reads the years as a numeric input.
#' The function will read all the csv files found in the directory, using the \code{fars_read_years}
#' function and bind them row-wise. It will then group the data based on year and
#' MONTH and summarize the data.
#'
#'@importFrom dplyr bind_rows
#'@importFrom dplyr group_by_
#'@importFrom dplyr summarize_
#'@importFrom tidyr spread_
#'@importFrom magrittr "%>%"
#'
#'@param years A vector of year to be searched
#'@return A dataset which is a Summary of all the relevant datasets in the directory,
#' binded row-wise, grouped-by the year and MONTH
#'
#'@example
#'\dontrun{
#' fars_summarize_years(c(2013,2014))
#'}
#'
#'@export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by_("year", "MONTH") %>%
    dplyr::summarize_(n = "n()") %>%
    tidyr::spread_("year", "n")
}


# Plots the points where accidents occured.
#'\code{fars_map_state} : This function takes the state number and the vector of years as input.
#' It will then find the relevant csv files using the \code{make_filename} function and will
#' read those csv files using the  \code{fars_read} function. If the state number is not found
#' it will display an error. Otherwise, it will filter the dataset, filtering the data with the
#' given state number. It then plots the points where the accidents have occured in that state.
#' If no accidents occured, a message is displayed.
#'
#'@importFrom dplyr filter_
#'@importFrom maps map
#'@importFrom graphics points
#'@return a data.frame of filtered data, if there are no rows then returns invisible(NULL)
#'
#'@example
#'\dontrun{
#' fars_map_state(1,2014)
#'}
#'
#'@export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter_(data, "STATE == state.num")
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
