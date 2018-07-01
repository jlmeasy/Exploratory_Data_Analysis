setwd("C:\\temp\\exdata_data_NEI_data")
#load the sqldf and ggplot2 libraries
library(ggplot2)
library(sqldf)
#inform R to use SQLite db
options(sqldf.driver="SQLite")
#load the data from the files
scc <- readRDS("./Source_Classification_Code.rds")
ssp <- readRDS("./summarySCC_PM25.rds")
#merge the data
mergedat <- merge(ssp,scc,by="SCC")
#look for the coal word in Short.Name column
coals <- mergedat[grepl("coal",mergedat$Short.Name,ignore.case=TRUE),]
#get the total emissions per year from Coals
dat <- sqldf("select year as Year, sum(emissions) as Emissions from coals group by year")
#save the file into PNG file
png(file = "./plot4.png")
gg <- ggplot(data=dat,aes(x=Year,y=Emissions)) + geom_point() + geom_line()
gg <- gg + labs(title="Emissions from Coal Sources in US")
print(gg)
dev.off()