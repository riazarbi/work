options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))
options(repos="https://packagemanager.rstudio.com/all/__linux__/focal/latest")
source("https://docs.posit.co/rspm/admin/check-user-agent.R")
Sys.setenv("NOT_CRAN" = TRUE)

packages <- c("readr",
              "gt",
              "dplyr",
              "yaml",
              "lubridate",
              "tidyr",
              "stringr",
              "snakecase")
install.packages(packages, Ncpus = 4L)
