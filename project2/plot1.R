# plot1.R
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

# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 1999, 2002, 
# 2005, and 2008.

# Read RDS files to the gloabl environment.
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Modify variable names to lower case.
names(NEI) <- tolower(names(NEI))

# Modify variables to data objects.
NEI$fips <- factor(NEI$fips)
NEI$scc <- factor(NEI$scc)
NEI$type <- factor(NEI$type)

emissions <- aggregate(NEI[, 'emissions'], by = list(NEI$year), FUN = sum)
names(emissions) <- c("year", "total.emission")
emissions$pm <- log10(emissions$total.emission)

png("./plot1.png")
barplot(emissions$pm,
  names.arg = emissions$year,
  main = expression(Total~Emission~of~PM[2.5]),
  xlab = 'Year',
  ylab = expression(PM[2.5]~'in'~kilotons~(log[10]~scale)))
dev.off()
