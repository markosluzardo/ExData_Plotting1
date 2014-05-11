# check the data file. unzip the data and download if necesary
fileZip <- "data/exdata-data-household_power_consumption.zip"
fileName <- "data/household_power_consumption.txt"
if (!file.exists("data")){
    dir.create("data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile = fileZip)
    unzip(fileZip, exdir="data")
}

# load the data from the two days. find the first day and take the range
# by the number of minutes contained in two days.
setClass("newdate")
setAs("character","newdate", function(from) as.Date(from, format="%d/%m/%Y") )

dataCols <- read.table(fileName, header = TRUE, sep = ";", nrows = 1)
dataDate <- read.table(fileName, header = TRUE, sep = ";", as.is = TRUE, 
                      colClasses = c("newdate", rep("NULL", 8)))
range <- (dataDate$Date == as.Date("01/02/2007", "%d/%m/%Y"))
toskip <- which.max(range)-1

data <- read.table(fileName, col.names = names(dataCols), header = TRUE, sep = ";", 
                  as.is = TRUE, skip = toskip, nrows = 60*48, na.strings = "?" )
rm(dataDate, range, toskip, dataCols)

# plot 1
png(file = "plot1.png", width = 480, height = 480, bg="transparent")
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)",
     col = "red")
dev.off()