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

# add new DateTime col to data
data$DateTime <- strptime(paste(data$Date, data$Time, sep= " "), format="%Y-%m-%d %H:%M:%S")

# open png device and make plot
png("plot3.png")
with(data, {
    plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l");
    lines(DateTime, Sub_metering_2, type="l", col="red");
    lines(DateTime, Sub_metering_3, type="l", col="blue");
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1, 1, 1))
})
dev.off()
