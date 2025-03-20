# plot4.R
# Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric", "numeric"))

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data for Feb 1-2, 2007
feb_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create a datetime column
datetime <- strptime(paste(feb_data$Date, feb_data$Time), format = "%Y-%m-%d %H:%M:%S")

# Open PNG device
png(filename = "plot4.png", width = 480, height = 480)

# Set up 2x2 plotting layout
par(mfrow = c(2, 2))

# Top-left: Global Active Power
plot(datetime, feb_data$Global_active_power, type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

# Top-right: Voltage
plot(datetime, feb_data$Voltage, type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

# Bottom-left: Energy sub metering
plot(datetime, feb_data$Sub_metering_1, type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(datetime, feb_data$Sub_metering_2, col = "red")
lines(datetime, feb_data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1, 
       bty = "n")  # bty="n" removes the legend box

# Bottom-right: Global Reactive Power
plot(datetime, feb_data$Global_reactive_power, type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

# Close the device
dev.off()
