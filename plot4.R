#Clean Up!
ls()
rm(list=ls())

#Read household energy usage: 2007-02-01 - 2007-02-02
usage_data <- "household_power_consumption.txt" #Either download file or grab from folder directly
hhold_data <- read.table(usage_data, header = TRUE, sep = ";", stringsAsFactors = FALSE)
head(hhold_data) #quick view of hhold_data table
#everything looks good :)

#Format Dates and Time classes to "Date" & "Time"
hhold_data$Date <- as.Date(hhold_data$Date, format = "%d/%m/%Y")
T_Update <- as.POSIXct(hhold_data$Time, format = "%H:%M:%S")
hhold_data$Time <- strftime(T_Update, "%H:%M:%S")

#Filter table to applicable dates: 2007-02-01 to 2007-02-02
appl_data <- filter(hhold_data, Date >= "2007-02-01", Date <= "2007-02-02")
head(appl_data) #view table

date_time <- strptime(paste(appl_data$Date, appl_data$Time, sep =" "), "%Y-%m-%d %H:%M:%S")

#create png file & plots
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2)) 

plot(date_time, as.numeric(appl_data$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(date_time, as.numeric(appl_data$Voltage), type = "l", xlab = "datetime", ylab = "Voltage")

plot(date_time, as.numeric(appl_data$Sub_metering_1), type = "l", xlab = "", ylab = "Energy Submetering")
lines(date_time, as.numeric(appl_data$Sub_metering_2), type = "l", col = "red")
lines(date_time, as.numeric(appl_data$Sub_metering_3), type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))

plot(date_time, as.numeric(appl_data$Global_reactive_power), type = "l", xlab = "", ylab = "Global_reactive_power")

dev.off()