# ggplot2.R
# Plotting with	ggplot2	

# Hello World Example
library("ggplot2")
qplot(displ, hwy, data=mpg)

# Modifying aesthetics	
qplot(displ, hwy, data=mpg, color=drv)

# Adding a geom
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))

# Histograms  
qplot(hwy, data=mpg, fill=drv)

# Facets
qplot(displ, hwy, data=mpg, facets=.~drv)
qplot(hwy, data=mpg, facets=drv~., binwidth=2)