library(DataCenterSim)
library(dplyr)

load("~/microsoft_10000.rda")

microsoft_max_10000 <- microsoft_max_10000[1:3000, c(1:3019)[-c(286,290,328,380,387,398,399,704,706,718,720,738,813,1571,1637,1638,2021,3012,3018)]]
microsoft_avg_10000 <- microsoft_avg_10000[1:3000, c(1:3019)[-c(286,290,328,380,387,398,399,704,706,718,720,738,813,1571,1637,1638,2021,3012,3018)]]

cut_off_prob <- c(0.001, 0.003, 0.01, 0.03, 0.05)
model <- "ZZN"
window_size <- c(10, 20, 30, 40, 50)

granularity <- 100 / 32

additional_setting <- list("cut_off_prob" = cut_off_prob)
bg_param_setting <- expand.grid(window_size = window_size, stringsAsFactors = FALSE)
bg_param_setting <- cbind(bg_param_setting, data.frame(class = "ETS", model = model, granularity = granularity, train_policy = "fixed", train_size = 2000, update_freq = 3, react_speed = "1,2", extrap_step = 1, stringsAsFactors = FALSE))
d <- run_sim(bg_param_setting, additional_setting, microsoft_max_10000, NULL, cores = parallel::detectCores(), write_type = c("charwise", "paramwise"), plot_type = "none", result_loc = "~/SimulationResult/SeasonalityModels/")

model <- "ZZZ"
window_size <- 1
freq <- 12
bg_param_setting <- data.frame(class = "ETS", name = "ETS(12)", granularity = granularity, type = type, window_size = window_size, freq = freq, train_policy = "fixed", train_size = 2000, update_freq = 3, react_speed = "1,2", extrap_step = 1, stringsAsFactors = FALSE)
d <- run_sim(bg_param_setting, additional_setting, microsoft_max_10000, NULL, cores = parallel::detectCores(), write_type = c("charwise", "paramwise"), plot_type = "none", result_loc = "~/SimulationResult/SeasonalityModels/")
