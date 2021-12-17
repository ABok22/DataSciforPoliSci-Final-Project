

## loading data and filtering it down to relevant observations, dates, and responses

load("combined.RData")

refined <- combined[, c("wave_date", "pid7_legacy","extra_covid_cancel_meet", "extra_covid_close_business", 
                      "extra_covid_close_schools", "extra_covid_restrict_home")]

aftermarch <- subset(refined, wave_date >= as.Date("2020-03-19"))

partisanship <- subset(aftermarch, pid7_legacy %in% c(1,2,3,4,5,6,7))

cancelmeet <- subset(partisanship,extra_covid_cancel_meet  %in% c(1,2,3,4))
               
closebusiness <- subset(cancelmeet,extra_covid_close_business  %in% c(1,2,3,4))

closeschools <- subset(closebusiness,extra_covid_close_schools  %in% c(1,2,3,4)) 

final <- subset(closeschools,extra_covid_restrict_home  %in% c(1,2,3,4))


### partisan divide
republicans <- subset(final,pid7_legacy %in% c(5,6,7))

democrats <- subset(final,pid7_legacy %in% c(1,2,3))


### Republican Averages
mean(republicans$extra_covid_cancel_meet)
mean(republicans$extra_covid_close_business)
mean(republicans$extra_covid_close_schools)
mean(republicans$extra_covid_restrict_home)

### Democrat Averages
mean(democrats$extra_covid_cancel_meet)
mean(democrats$extra_covid_close_business)
mean(democrats$extra_covid_close_schools)
mean(democrats$extra_covid_restrict_home)


### Republican Vector 
Republican <- c(1.961615,1.976426,1.998041,2.202612)

### Democrat Vector
Democrat <- c(1.484633,1.504294,1.552635,1.741611)

## Combine Vectors
PartisanSplit <- cbind(Republican,Democrat)


### Visualization
barplot(PartisanSplit,beside=T,
col= c("red1", "red2","red3","red4","blue1","blue2","blue3","blue4"),
ylim =  c(0, 4), 
names = c("Cancel Meetings", "Close Businesses", "Close Schools", 
          "Stay-at-home orders","Cancel Meetings", "Close Businesses", "Close Schools", 
          "Stay-at-home orders"),
main = "Partisan Attitudes Toward COVID-19 Mitigation Measures", 
cex.main = 0.8, 
ylab = "Average Response Value",
xlab = "Mitigation Measure",
cex.lab = 0.8,
cex.names = 0.531,
las = 1) 
abline(h=0, col = "black") 
legend("topright",  col=c("red", "blue"), 
       c("Republican", "Democrat"), cex = .7, lty=1,lwd=5,
       bty="n")





