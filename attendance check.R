setwd("~/Desktop/")
attendance<- read.csv("zoomus_meeting_report_92892626650.csv", header =T, sep =",", dec =".")
roster<-read.csv("roster.csv", header =T, sep =",", dec =".")

library(dplyr)
attendees<-as.data.frame(attendance$Name)
attendees1<-unique(attendees)
names(attendees1)[1] <- "Name"
absent<-dplyr::setdiff(roster, attendees1)
