# plot2.R
# Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric", "numeric"))

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data for Feb 1-2, 2007
feb_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create a datetime column by combining Date and Time
datetime <- strptime(paste(feb_data$Date, feb_data$Time), format = "%Y-%m-%d %H:%M:%S")

# Open PNG device
png(filename = "plot2.png", width = 480, height = 480)

# Create line plot
plot(datetime, feb_data$Global_active_power, type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Close the device
dev.off()
