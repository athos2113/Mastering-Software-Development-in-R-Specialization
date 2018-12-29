#Longitudinal Data Class and Methods
#We are going to create classes. Each class has -> Methods
# 1. LongitudinalData -> print,subject
# 2. subject -> print, summary, visit
# 3. visit -> room
# 4. room -> print, summary
# 4. Summary -> print


#Additionally, we will create 4 functions. Each function has a -> function type
# 1. make_LD : : a function that converts a data frame into a "LongitudinalData" object
# 2. subject :  a generic function for extracting subject-specific information
# 3. visit : a generic function for extracting visit-specific information
# 4. room : a generic function for extracting room-specific information

# Load libraries ---------------------------------------------------------------
library(dplyr)
library(tidyr)


# Define generic functions -----------------------------------------------------
subject <- function(ld_df, id) UseMethod("subject")

visit <- function(subject, visit_numb) UseMethod("visit")

room <- function(visit, room_name) UseMethod("room")



# Define methods for LongitudionalData objects ---------------------------------
make_LD <- function(df) {
  ld_df <- df %>% nest(-id)
  structure(ld_df, class = c("LongitudinalData"))
}

print.LongitudinalData <- function(x) {
  cat("Longitudinal dataset with", length(x[["id"]]), "subjects")
  invisible(x)
}

subject.LongitudinalData <- function(ld_df, id) {
  index <- which(ld_df[["id"]] == id)
  if (length(index) == 0)
    return(NULL)
  structure(list(id = id, data = ld_df[["data"]][[index]]), class = "Subject")
}


# Define methods for Subject objects -------------------------------------------
print.Subject <- function(x) {
  cat("Subject ID:", x[["id"]])
  invisible(x)
}

summary.Subject <- function(object) {
  output <- object[["data"]] %>% 
    group_by(visit, room) %>%
    summarise(value = mean(value)) %>% 
    spread(room, value) %>% 
    as.data.frame
  structure(list(id = object[["id"]],
                 output = output), class = "Summary")
}

visit.Subject <- function(subject, visit_num) {
  if (!visit_num %in% 0:2)
    stop("The visit number must be 0, 1 or 2")
  data <- subject[["data"]] %>% 
    filter(visit == visit_num) %>% 
    select(-visit)
  structure(list(id = subject[["id"]],
                 visit_num = visit_num,
                 data = data), class = "Visit")
}


# Define methods for Visit objects ---------------------------------------------
room.Visit <- function(visit, room_name) {
  if (!room_name %in% visit[["data"]][["room"]])
    stop("Please provide a room name which was part of the visit")
  data <- visit[["data"]] %>% 
    filter(room == room_name) %>% 
    select(-room)
  structure(list(id = visit[["id"]],
                 visit_num = visit[["visit_num"]],
                 room = room_name,
                 data = data), class = "Room")
}

# Define methods for Room objects ----------------------------------------------
print.Room <- function(x) {
  cat("ID:", x[["id"]], "\n")
  cat("Visit:", x[["visit_num"]], "\n")
  cat("Room:", x[["room"]])
  invisible(x)
}

summary.Room <- function(object) {
  output <- summary(object[["data"]][["value"]])
  structure(list(id = object[["id"]],
                 output = output), class = "Summary")
}

# Define methods for Summary objects -------------------------------------------
print.Summary <- function(x) {
  cat("ID:", x[[1]], "\n")
  print(x[[2]])
  invisible(x)
}