library(readr)
library(dplyr)
library(lubridate)
library(tidyr)
library(stringr)
library(snakecase)

work_log <- ifelse(file.exists("task_logging/work.txt"), 
               "task_logging/work.txt", 
               "examples/work.txt")

payments_log <- ifelse(file.exists("task_logging/payments.txt"), 
                   "task_logging/payments.txt", 
                   "examples/payments.txt")

work <- read_delim(work_log, delim=";")
payments <- read_delim(payments_log, delim=";")

work |> 
  mutate(across(everything(), str_trim)) |>
  mutate(Duration = as.numeric(Duration),
         Project = to_upper_camel_case(Project)) |>
  mutate(Hours = Duration / 60) |> 
  mutate(Rate = as.numeric(Rate)) |>
  mutate(Timestamp = as_datetime(Timestamp)) |>
  mutate(Amount = Rate * Hours) |>
  group_by(Project) |>
  summarise(Hours = sum(Hours),
            Total = sum(Amount))

payments |> 
  mutate(across(everything(), str_trim)) |>
  mutate(Amount = as.numeric(Amount),
         Project = to_upper_camel_case(Project),
         Account = to_upper_camel_case(Account),
         `Record Date` = as_datetime(`Record Date`),
         `Received Date` = as_datetime(`Received Date`)) |>
  group_by(Project) |>
  summarise(Amount = sum(Amount))
