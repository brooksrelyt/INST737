#   INST737
#   Final Project submission from Zac Beitzel, Ty Brooks, and Siwei Zhang
#   April 26th, 2018

#   Overview of Project:
#   Our project is creating a predictive analytics model for NCAA Division 1 Men's Basketball, in order to help determine when two teams play against 
#   each other during the Division 1 post-season single elimination tournaments (March Madness and NIT), which team will win each matchup. 


# We stored the 2017-18 season of NCAA Division 1 Men's Basketball basketball team statistics at the below URL on Github, which we read in for use in R
Season_Stats_201718 <- read.csv(url("https://raw.githubusercontent.com/brooksrelyt/INST737/master/NCAA_Basketball_Season_Stats_2017_18.csv"))

# We stored the 2017-18 post-season single elimination tournament matchups in the following file (along with the actual winner, 
# as the post-season is now over), so that we can test out predictive model with the actual results of the matchup
Postseason_Matchups_201718 <- read.csv(url("https://raw.githubusercontent.com/brooksrelyt/INST737/master/NCAA_Basketball_Post_Season_Matchups_2017-18.csv"))

names(Postseason_Matchups_201718)=c("Tournament_Type","Rk","Rk2","Winner_ID")

a=merge(Season_Stats_201718,Postseason_Matchups_201718, by="Rk")

colnames(a)[colnames(a)=="Rk"] <- "Team1"
colnames(a)[colnames(a)=="Rk2"] <- "Rk"
colnames(a)[colnames(a)=="Rk"] <- "Rk"

View(Season_Stats_201718)

b=merge(Season_Stats_201718,a, by="Rk")

colnames(b)[colnames(b)=="Rk"] <- "Team2"

write.csv(b,file="E:/2018 spring/INST 737/project/merge201718.csv", row.names=F)
