# plot6.R
#
#  Copyright 2015 Nick Hepler <nick.hepler@outlook.com>
#
#  Version 0.0.1
#
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#

# Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in 
# motor vehicle emissions?

require(ggplot2)

# Read RDS files to the gloabl environment.
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Modify variable names to lower case.
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Locate coal usage in SCC data frame.
b.emissions.data <- subset(NEI, fips == "24510" & type == 'ON-ROAD')
l.emissions.data <- subset(NEI, fips == "06037" & type == 'ON-ROAD')

# Total the results into a new tidy data frame
b.emissions.sum <- aggregate(b.emissions.data[, 'emissions'], 
  by = list(b.emissions.data$year), sum)
names(b.emissions.sum) <- c('Year', 'Emissions')
b.emissions.sum$City <- "Baltimore"

l.emissions.sum <- aggregate(l.emissions.data[, 'emissions'], 
  by = list(l.emissions.data$year), sum)
names(l.emissions.sum) <- c('Year', 'Emissions')
l.emissions.sum$City <- "Los Angeles"

mv.emissions <- as.data.frame(rbind(b.emissions.sum, l.emissions.sum))

png(filename = 'plot6.png')
qplot(data=mv.emissions,
  main='Motor Vehicle Emissions Between 1999–2008',
  x=Year,
  y=log10(Emissions),
  geom="line",
  colour=City)
dev.off()