# plot3.R
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
png(filename = "plot3.png", width = 480, height = 480)

# Plot Sub_metering_1
plot(datetime, feb_data$Sub_metering_1, type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")

# Add Sub_metering_2 in red
lines(datetime, feb_data$Sub_metering_2, col = "red")

# Add Sub_metering_3 in blue
lines(datetime, feb_data$Sub_metering_3, col = "blue")

# Add a legend in the top right corner
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1)

# Close the device
dev.off()
