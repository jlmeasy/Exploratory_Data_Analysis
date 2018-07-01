setwd("C:\\temp\\exdata_data_NEI_data")
#load the sqldf and ggplot2 libraries
library(ggplot2)
library(sqldf)
#tell R to use SQLite db
options(sqldf.driver = "SQLite")
#load the data from file
ssp <- readRDS("./summarySCC_PM25.rds")
#get the total emission per year for all the motor vehicles in Baltimore
dat <- sqldf("select year as Year, sum(emissions) as Emissions from ssp where fips = '24510' and type= 'ON-ROAD' group by year")
#save the file to PNG
png(file = "./plot5.png")
gg <- ggplot(data=dat,aes(x=Year,y=Emissions)) + geom_point() + geom_line()
gg <- gg + labs(title="Emissions from Motor Vehicle Sources in Baltimore")
print(gg)
dev.off()