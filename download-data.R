library(tidyverse)
library(haven)
library(ipumsr)

ipums_extract <- read_dta("usa_00001.dta")

ipums_extract <-
  ipums_extract |>
  select(stateicp, educd) 

cleaned_ipums <-
  ipums_extract |>
  # mutate(age = as.numeric(age)) |>
  # filter(age >= 18) |>
  # rename(gender = sex) |>
  mutate(
    education_level = case_when(
      educd %in% c(
        "nursery school, preschool", "kindergarten", "grade 1",
        "grade 2", "grade 3", "grade 4", "grade 5", "grade 6",
        "grade 7", "grade 8", "grade 9", "grade 10", "grade 11",
        "12th grade, no diploma", "regular high school diploma",
        "ged or alternative credential", "no schooling completed"
      ) ~ "High school or less",
      educd %in% c(
        "some college, but less than 1 year",
        "1 or more years of college credit, no degree"
      ) ~ "Some post sec",
      educd  %in% c("associate's degree, type not specified",
                    "bachelor's degree") ~ "Post sec +",
      educd %in% c(
        "master's degree",
        "professional degree beyond a bachelor's degree",
        "doctoral degree"
      ) ~ "Grad degree",
      TRUE ~ "Trouble"
    )
  ) |>
  select(education_level, stateicp) |>
  mutate(across(c(stateicp, education_level),
    as_factor)) 

cleaned_ipums