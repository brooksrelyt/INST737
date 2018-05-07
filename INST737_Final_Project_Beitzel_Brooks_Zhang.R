#   INST737
#   Final Project submission from Zac Beitzel, Ty Brooks, and Siwei Zhang
#   April 26th, 2018

#   Overview of Project:
#   Our project is creating a predictive analytics model for NCAA Division 1 Men's Basketball, in order to help determine when two teams play against 
#   each other during the Division 1 regular season and also the post-season single elimination tournaments (March Madness and NIT), which team will win each matchup. 

# We'd like to cite the website Sports-Referece.com for this project, as that website is where we were able to retrieve data regarding season-long statistics for the teams that we analyze,
# as well as the team matchups (and the winners of the matchups) that we use to train our prediction model

# We stored the 2017-18 season of NCAA Division 1 Men's Basketball basketball team statistics at the below URL on Github, which we read in for use in R. We found the data from this URL from Sports-Reference.com (https://www.sports-reference.com/cbb/seasons/2018-school-stats.html)
Season_Stats_201718 <- read.csv(url("https://raw.githubusercontent.com/brooksrelyt/INST737/master/NCAA_Basketball_Season_Stats_2017_18.csv"));

# We stored the 2016-17 season of NCAA Division 1 Men's Basketball basketball team statistics at the below URL on Github, which we read in for use in R. We found the data from this URL from Sports-Reference.com (https://www.sports-reference.com/cbb/seasons/2017-school-stats.html)
Season_Stats_201617 <- read.csv(url("https://raw.githubusercontent.com/brooksrelyt/INST737/master/NCAA_Basketball_Season_Stats_2016_17.csv"));

# We stored the 2017-18 matchups (regular season and post-season) in the following file (along with the actual winner, 
# as the post-season is now over), so that we can test out predictive model with the actual results of the matchup. 
# This data is available from Sports-Reference from the following URL (https://www.sports-reference.com/cbb/play-index/matchup_finder.cgi?request=1&year_min=2018&year_max=2018&school_id=&opp_id=&game_type=A&game_month=&game_location=&game_result=W&is_overtime=&comp_school=eq&comp_opp=eq&rank_school=ANY&rank_opp=ANY&order_by=date_game&order_by_asc=&offset=0)
Matchups_201718 <- read.csv(url("https://raw.githubusercontent.com/brooksrelyt/INST737/master/NCAA_Matchups_2017_2018.csv"));

# We stored the 2016-17 matchups (regular season and post-season) in the following file (along with the actual winner, so that we can test out predictive model with the actual results of the matchup. 
# This data is available from Sports-Reference from the following URL (https://www.sports-reference.com/cbb/play-index/matchup_finder.cgi?request=1&year_min=2017&year_max=2017&comp_school=eq&rank_school=ANY&comp_opp=eq&rank_opp=ANY&game_type=A&game_result=W&order_by=date_game)
Matchups_201617 <- read.csv(url("https://raw.githubusercontent.com/brooksrelyt/INST737/master/NCAA_Matchups_2016_2017.csv"));


# Here will create a data frame that will hold the matchups for 16-17, as well as the season-long statistics for the two teams in the matchup
Matchups_201617_With_Stats <- merge(Matchups_201617, Season_Stats_201617, by.x=c("Team_A_ID"), by.y=c("School_ID"));
Matchups_201617_With_Stats <- merge(Matchups_201617_With_Stats, Season_Stats_201617, by.x=c("Team_B_ID"), by.y=c("School_ID"));

# Sorting the above data frame by Date the game was played (ascending)
Matchups_201617_With_Stats <- Matchups_201617_With_Stats[order(as.Date(Matchups_201617_With_Stats$Date, format="%m/%d/%Y")),];

write.csv(Matchups_201617_With_Stats,file="Matchups_201617_With_Stats.csv", row.names=FALSE)
