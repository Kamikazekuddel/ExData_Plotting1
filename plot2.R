if (!file.exists('household_power_consumption.txt')) {
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip','data.zip','curl')
  unzip('data.zip',exdir='.')
}

require('dplyr')

power_df<- read.csv('household_power_consumption.txt',
                    sep=';',
                    na.strings = "?",
                    stringsAsFactors = FALSE) %>%
          as_tibble() %>%
          mutate(datetime= as.POSIXct(paste(Date,Time,sep=" "),format = "%d/%m/%Y %H:%M:%S"),Date = as.Date(Date,'%d/%m/%Y')) %>%
          filter(between(Date,as.Date("2007-02-01"),as.Date("2007-02-02")))

options(scipen=999)
Sys.setlocale("LC_ALL","English") #So Days of the week are written in english
png('plot2.png')
with(power_df,plot(datetime,
                   Global_active_power,
                   type = 'l',
                   yaxp = c(0,6,3),
                   ylab = "Global Active Power (kilowatts)",
                   xlab =""
                   )
     )
dev.off()
