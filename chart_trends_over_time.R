library(dplyr)
library(readr)
library(ggplot2)

county_jail_rates <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")

total_black_latinx_pop_rate <- county_jail_rates %>%
  group_by(year) %>%
  summarize(average_black_jail_pop_rate = mean(black_jail_pop_rate, na.rm = TRUE),
            average_latinx_jail_pop_rate = mean(latinx_jail_pop_rate, na.rm = TRUE),
            average_white_jail_pop_rate = mean(white_jail_pop_rate, na.rm = TRUE))

# Create the plot
ggplot(total_black_latinx_pop_rate, aes(x = year)) +
  geom_line(aes(y = average_black_jail_pop_rate, color = "Black Jail Population")) +
  geom_line(aes(y = average_latinx_jail_pop_rate, color = "Latinx Jail Population")) +
  geom_line(aes(y = average_white_jail_pop_rate, color = "White Jail Population")) +
  labs(title = "Black and Latinx Compared to White Jail Populations Over Time",
       x = "Year",
       y = "Jail Population",
       color = "Population Group")

