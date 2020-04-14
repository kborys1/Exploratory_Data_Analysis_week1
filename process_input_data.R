library(data.table)

### run it once to prepare small input data file

dt <- fread("household_power_consumption.txt")

dt[,Date := as.Date(Date, format = "%d/%m/%Y")]
dt_2days <- dt[Date >= "2007/2/1" & Date <= "2007/2/2",]

fwrite(dt_2days, "household_power_consumption_2days.txt")
