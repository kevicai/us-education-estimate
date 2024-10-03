library(tidyverse)
library(haven)
library(ipumsr)

ipums_extract <- read_dta("data/usa_00002.dta")

ipums_extract <-
  ipums_extract |>
  select(stateicp, educd) |>
  mutate(
    stateicp = as_factor(stateicp),
    educd = as_factor(educd)
  )

ipums_extract

write_csv(
  x = ipums_extract,
  file = "data/cleaned_ipums.csv"
)
