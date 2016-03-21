require("Rfacebook")

token<-"CAACEdEose0cBAFboWpFvc9qJdAYSN86VXuAQ7KMRzqFw9dlIkCqrwlt5dLK99wktBaNgobMFRr8mHUcOOTHsHDbvthHtvaby60HhQx5gW3yZAAemDkwzzdfZAZAN3vRREMAyEMlJd4JSgZC3NGZCqFu0ZBbl9h4XC3oc5KT4DwHNfJF1ksHBqZAGHQywMZCerFZCGyFE0NtJ8pXVHfmiGoIFn"
token2 <- '131388257217054|nGr6Cz3ThkAC2sGEKXNihdPRNr0'
CarDekho_lastweek<- getPage("CarDekho", token, n = 10)   
CarToq_lastweek<- getPage("CarToq", token, n = 10)
CarTrade_lastweek<- getPage("CarTrade", token, n = 10)
CarWale_lastweek<- getPage("CarWale", token, n = 10)
odmag_lastweek<- getPage("odmag", token, n = 10)
TopGearIndia_lastweek<- getPage("TopGearIndia", token, n = 10)
zigwheels_lastweek<- getPage("zigwheels", token, n = 10)
autocarindiamag_lastweek<- getPage("autocarindiamag", token, n = 10)

setwd('D:\\')
write.csv(CarDekho_lastweek,"D:/CarDekho.csv")
write.csv(CarToq_lastweek,"D:/CarToq.csv")
write.csv(CarTrade_lastweek,"D:/CarTrade.csv")
write.csv(CarWale_lastweek,"D:/CarWale.csv")
write.csv(odmag_lastweek,"D:/Overdrive.csv")
write.csv(TopGearIndia_lastweek,"D:/TopGearIndia.csv")
write.csv(zigwheels_lastweek,"D:/ZigWheels.csv")
write.csv(autocarindiamag_lastweek,"D:/AutocarIndia.csv")

data1 <- read.csv("CarDekho.csv")
data2 <- read.csv("CarToq.csv")
data3 <- read.csv("CarTrade.csv")
data4 <- read.csv("CarWale.csv")
data5 <- read.csv("Overdrive.csv")
data6 <- read.csv("TopGearIndia.csv")
data7 <- read.csv("ZigWheels.csv")
data8 <- read.csv("Autocarindia.csv")

Merge <- rbind(data1,data2,data3,data4,data5,data6,data7,data8)

write.csv(Merge,"1.Final_Data.csv")
data10 <- read.csv("1.Final_Data.csv")

#added by AMR

CarDekho_lastweek$posttime <- strptime(CarDekho_lastweek$created_time,format='%Y-%m-%dT%H:%M:%S %z')

CarDekho_lastweek[CarDekho_lastweek$posttime[[3]]<10 | CarDekho_lastweek$posttime[[3]]>=19]

data10$posttime <- strptime(data10$created_time,format='%Y-%m-%dT%H:%M:%S %z')

data10$posttime[data10$posttime[[3]]<11 | data10$posttime[[3]]>=19]


#16hours 19:00 - 11:00

cardekho7to11 <- getPage("CarDekho", token2, since = Sys.time()-57600, until = Sys.time())

carToq7to11 <- getPage("CarToq", token2, since = Sys.time()-57600)

#strptime(carToq7to11$created_time,format='%Y-%m-%dT%H:%M:%S %z')



