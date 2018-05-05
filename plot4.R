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
          mutate(datetime= as.POSIXct(paste(Date,Time,sep=" "),
                                      format = "%d/%m/%Y %H:%M:%S"),
                 Date = as.Date(Date,'%d/%m/%Y')) %>%
          filter(between(Date,as.Date("2007-02-01"),as.Date("2007-02-02")))

options(scipen=999)
Sys.setlocale("LC_ALL","English") #So Days of the week are written in english
png('plot4.png')
with(power_df,{
  par(mfcol = c(2,2))
  
  #upper left
  plot(datetime,
   Global_active_power,
   type = 'l',
   yaxp = c(0,6,3),
   ylab = "Global Active Power (kilowatts)",
   xlab =""
   )
  
  #lower left
  plot(datetime,
   Sub_metering_1,
   type = 'l',
   col = 'black',
   yaxp = c(0,30,3),
   ylab = "Energy sub metering",
   xlab =""
   )
 points(datetime,
        Sub_metering_2,
        type = 'l',
        col = 'red')
 points(datetime,
        Sub_metering_3,
        type = 'l',
        col = 'blue')
 legend('topright',
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col = c("black","red","blue"),
        bty= 'n',
        lwd=1)
 
 #upper right
 plot(datetime,
      Voltage,
      t = 'l')
 
 #lower right 
 plot(datetime,
      Global_reactive_power,
      t = 'l')
    })
dev.off()
