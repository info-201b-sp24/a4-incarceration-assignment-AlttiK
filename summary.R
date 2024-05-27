
library(dplyr)
library(tidyverse)

county_jail_rates <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")

county_current <- county_jail_rates %>% filter(year == max(year)) 

county_black_jail_rate_average <- county_current %>% summarise(average_black_jail_pop_rate = mean(black_jail_pop_rate, na.rm = TRUE)) %>% pull(average_black_jail_pop_rate)

county_white_jail_rate_average <- county_current %>% summarise(average_white_jail_pop_rate = mean(white_jail_pop_rate, na.rm = TRUE)) %>% pull(average_white_jail_pop_rate)

current_max_total_jail_pop <- county_current %>% filter(total_jail_pop_rate == max(total_jail_pop_rate, na.rm = TRUE)) %>% pull(total_jail_pop_rate)

current_highest_county_jail_pop <- county_current %>% filter(total_jail_pop_rate == max(total_jail_pop_rate, na.rm = TRUE)) %>% pull(county_name)

current_min_total_jail_pop <- county_current %>% filter(total_jail_pop_rate == min(total_jail_pop_rate, na.rm = TRUE)) %>% pull(total_jail_pop_rate)

current_lowest_county_jail_pop <- county_current %>% filter(total_jail_pop_rate == min(total_jail_pop_rate, na.rm = TRUE)) %>% pull(county_name)

county_jail_rates <- mutate(county_jail_rates, change_in_pop_rate = (total_jail_pop_rate - lag(total_jail_pop_rate)))

average_change_in_pop_rate <- county_jail_rates %>% filter(year == max(year)) %>% summarise(average_change = mean(change_in_pop_rate, na.rm = TRUE)) %>% pull(average_change)

print(paste0("Average current Black jail rate: ", county_black_jail_rate_average))
print(paste0("Average current White jail rate: ", county_white_jail_rate_average))
print(paste0("Current highest jail pop: ", current_highest_county_jail_pop, " with a jail pop of ", current_max_total_jail_pop))
print(paste0("5 places have 0 jail pop: ", current_lowest_county_jail_pop))
print(paste0("Average change since 2017: ", average_change_in_pop_rate))

