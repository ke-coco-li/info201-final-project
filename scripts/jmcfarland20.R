library("dplyr")

wide <- read.csv("data/Affordability_Wide_2018Q4_Public.csv", stringsAsFactors = F)

is.data.frame(wide)

# Pair down data frame to 2018
wide_2018 <- wide %>%
  select(RegionID,
         RegionName,
         SizeRank,
         Index,
         X2018.03,
         X2018.06,
         X2018.09,
         X2018.12) %>%
  rowwise() %>%
  mutate(mean_2018 = mean(X2018.03, X2018.06, X2018.09, X2018.12, na.rm = T))

# Separate price to income, morgtage affordability, and rent affordability
price_income18 <- wide_2018 %>%
  filter(Index == "Price To Income")

mortgage18 <- wide_2018 %>%
  filter(Index == "Mortgage Affordability")

rent18 <- wide_2018 %>%
  filter(Index == "Rent Affordability")
