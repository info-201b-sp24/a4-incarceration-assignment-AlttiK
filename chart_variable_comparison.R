
library(dplyr)
library(readr)
library(ggplot2)

county_jail_rates <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")

county_current <- county_jail_rates %>% filter(year == max(year))

ggplot(county_current, aes(x = white_jail_pop_rate, y = black_jail_pop_rate + latinx_jail_pop_rate)) +
  geom_point() +
  labs(title = "County Black and Latinx Jail Population Rate vs. White Jail Population Rate",
       x = "White Jail Population Rate",
       y = "Black and Latinx Jail Population Rate") +
  scale_y_continuous(limits = c(0, 90000), breaks = seq(0, 90000, by = 20000))
