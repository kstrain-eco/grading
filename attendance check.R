setwd("~/Desktop/")
#import the attendance list from zoom app(canvas>zoom>date>report>download) and roster
attendance<- read.csv("DEC2.csv", header =T, sep =",", dec =".") 
roster<-read.csv("roster.csv", header =T, sep =",", dec =".") #class roster

##-----ABSENCES---------------------------------------------------------------------------
#Identify who was absent by checking for discrepancies between the roster and attendees
library(dplyr)
attendees<-as.data.frame(attendance$Name)   #make a dataframe from Names of attendees
attendees1<-unique(attendees)               #get rid of multiple entries (like if someones wifi cuts out)
names(attendees1)[1] <- "Name"              #rename the column, if needed
absent<-dplyr::setdiff(roster, attendees1)  #if in one list but not another please subset, make a new list
#NOTE: always cross-check the original, since students can change their zoom names


##-----TARDIES---------------------------------------------------------------------------
#sum duration by name for total attendance time
time<-aggregate(attendance$Duration.Minutes., by=list(Category=attendance$Name), FUN=sum)

#subset students considered late (for this class, <30 min duration)
late <- subset(time, x <30, 
                  select=c(x, Category))
                  #x is  total time  attended, if this  list is short enough you can omit the next step
#NOTE: this is total time, so students who leave early will also be counted as late.


##-----OPTIONAL: STUDENTS SO LATE, THEY DO NOT GET ATTENDANCE CREDIT---------------------------------------------------------------------------
#Students so late they're considered absent (<15 min duration)
late_absent <- subset(late, x<15, select=Category)
names(late_absent)[1] <- "Name"              #rename the column

#Combine absent and late_absent so they're one list.
absent2 <- rbind(absent, late_absent)

