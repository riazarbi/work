library(readr)
library(dplyr)
library(lubridate)
library(tidyr)
library(stringr)
library(snakecase)

work <- read_delim("task_logging/work.txt", delim=";")
payments <- read_delim("task_logging/payments.txt", delim=";")

work |> 
  mutate(across(everything(), str_trim)) |>
  mutate(typical_duration_min = as.numeric(typical_duration_min),
         context = to_upper_camel_case(context)) |>
  mutate(hours = typical_duration_min / 60) |> 
  mutate(rate = as.numeric(rate)) |>
  mutate(Timestamp = as_datetime(Timestamp)) |>
  mutate(Amount = rate * hours) |>
  group_by(context) |>
  summarise(Hours = sum(hours),
            Total = sum(Amount))


         