# plotting_systems.R
# Plotting Systems in R


# Base Plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))


# Lattice Plot
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))


# ggplot2 Plot
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)
