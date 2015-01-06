# download and unzip data file
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, "household_power_consumption.zip", method="curl")
    unzip("household_power_consumption.zip")
}

# load data into memory
hpc <- read.table(dataFile, sep=";", na.strings="?", header=TRUE)

# convert from factor to Date
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

# filter data set on date
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
f <- hpc$Date == d1 | hpc$Date == d2
data <- hpc[f,]

# open png device and make plot
png("plot1.png")
with(data, hist(Global_active_power, xlab="Global Active Power (kilowats)", main="Global Active Power", col="red"))
dev.off()
