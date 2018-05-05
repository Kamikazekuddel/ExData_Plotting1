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
          mutate(Date = as.Date(Date,'%d/%m/%Y')) %>%
          filter(between(Date,as.Date("2007-02-01"),as.Date("2007-02-02")))

options(scipen=999)    
png('plot1.png')
with(power_df,hist(Global_active_power
                   ,col='red'
                   ,main=" Global Active Power"
                   ,xlab = 'Global Active Power (kilowatts)'
                   ,xlim = c(0,7)
                   ,xaxp= c(0,6,3)
                   ,yaxp = c(0,1200,6)
                   ,ylim = c(0,1200))
     )
dev.off()
