library(maps)
library(mapproj)
library(tidyverse)
library(ggplot2)
library(dplyr)

states <- map_data("state")

states <- merge(states, data.frame(region = tolower(state.name), abb = state.abb), by = "region", all.x = TRUE)

county_jail_rates <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")

county_jail_rates <- mutate(county_jail_rates, change_in_pop_rate = (total_jail_pop_rate - lag(total_jail_pop_rate, 10)))

county_current <- county_jail_rates %>% filter(year == max(year)) 

state_change_in_jail_pop <- county_current %>% group_by(state) %>% summarise(state_change_in_pop = sum(change_in_pop_rate, na.rm = TRUE)) 

state_change_in_jail_pop <- state_change_in_jail_pop %>% filter(state != "DC")

change_in_jail_pop.geo <- merge(states, state_change_in_jail_pop, by.x = "abb", by.y = "state", all.x = TRUE)
change_in_jail_pop.geo <- change_in_jail_pop.geo[order(change_in_jail_pop.geo$order), ]

ggplot(change_in_jail_pop.geo, aes(x = long, y = lat, group = group, fill = state_change_in_pop)) +
  geom_polygon() +
  coord_map() +
  scale_fill_gradient2(name = "Change in Jail Pop Rate", limit = c(-5000, 35000), low = "green", mid = "white", high = "red", midpoint = 1000) +
  labs(title = "Change in Jail Population Rates by State from 2008-18")

