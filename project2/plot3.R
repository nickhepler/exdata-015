# plot3.R
#
#  Copyright 2015 Nick Hepler <nick.hepler@outlook.com>
#
#  Version <0.0.1>
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
require(ggplot2)

# Read RDS files to the gloabl environment.
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Modify variable names to lower case.
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Modify variables to data objects.
NEI$fips <- factor(NEI$fips)
NEI$scc <- factor(NEI$scc)
NEI$type <- factor(NEI$type)

emissions <- subset(NEI, fips == '24510')

png("./plot3.png")
ggplot(data = emissions, 
  aes(x = year, y = log(emissions))) + 
  facet_grid(. ~ type) + guides(fill = F) + 
  geom_boxplot(aes(fill = type)) + 
  stat_boxplot(geom = 'errorbar') + 
  ylab(expression(Log~of~of~PM[2.5]~Emissions)) + 
  xlab('Year') + 
  ggtitle(Emissions~per~Type~'in'~Baltimore~MD) + 
  geom_jitter(alpha = 0.10)
dev.off()