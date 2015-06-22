# plot4.R
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

# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

require(ggplot2)

# Read RDS files to the gloabl environment.
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Modify variable names to lower case.
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Locate coal usage in SCC data frame.
coal <- SCC[grepl("coal", SCC$short.name, ignore.case = TRUE), ]

# Merge the results with the NEI data frame.
emissions <- merge(x = NEI, y = coal, by = 'scc')

# Total the results into a new tidy data frame
emissions.sum <- aggregate(emissions[, 'emissions'], by = list(emissions$year), sum)
names(emissions.sum) <- c('Year', 'Emissions')

png(filename = 'plot4.png')
qplot(data=emissions.sum,
  main='U.S. Emissions From Coal Combustion-Related Sources',
  x=Year,
  y=log10(Emissions),
  geom="line")
dev.off()