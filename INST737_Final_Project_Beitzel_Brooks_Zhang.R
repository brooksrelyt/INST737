#   INST737
#   Final Project submission from Zac Beitzel, Ty Brooks, and Siwei Zhang
#   April 26th, 2018

#   Overview of Project:
#   Our project is creating a predictive analytics model for NCAA Division 1 Men's Basketball, in order to help determine when two teams play against 
#   each other during the Division 1 regular season and also the post-season single elimination tournaments (March Madness and NIT), which team will win each matchup. 

install.packages("expss")

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


# Here we will create a data frame that will hold the matchups for 16-17, as well as the season-long statistics for the two teams in the matchup
Matchups_201617_With_Stats <- merge(Matchups_201617, Season_Stats_201617, by.x=c("Team_A_ID"), by.y=c("School_ID"));
Matchups_201617_With_Stats <- merge(Matchups_201617_With_Stats, Season_Stats_201617, by.x=c("Team_B_ID"), by.y=c("School_ID"));

# Sorting the above data frame by Date the game was played (ascending)
Matchups_201617_With_Stats <- Matchups_201617_With_Stats[order(as.Date(Matchups_201617_With_Stats$Date, format="%m/%d/%Y")),];

# Create columns that compare statistical categories between two teams for the 2016-17 year
Matchups_201617_With_Stats$ORtg_Difference <- Matchups_201617_With_Stats$ORtg.x - Matchups_201617_With_Stats$ORtg.y;
Matchups_201617_With_Stats$True_Shooting_Percentage_Difference <- Matchups_201617_With_Stats$True_Shooting_Percentage.x - Matchups_201617_With_Stats$True_Shooting_Percentage.y;
Matchups_201617_With_Stats$True_Rebound_Percentage_Difference <- Matchups_201617_With_Stats$True_Rebound_Percentage.x - Matchups_201617_With_Stats$True_Rebound_Percentage.y;
Matchups_201617_With_Stats$Steal_Percentage_Difference <- Matchups_201617_With_Stats$Steal_Percentage.x - Matchups_201617_With_Stats$Steal_Percentage.y;
Matchups_201617_With_Stats$TO_Percentage_Difference <- Matchups_201617_With_Stats$TO_Percentage.x - Matchups_201617_With_Stats$TO_Percentage.y;
Matchups_201617_With_Stats$Block_Percentage_Difference <- Matchups_201617_With_Stats$Block_Percentage.x - Matchups_201617_With_Stats$Block_Percentage.y;
Matchups_201617_With_Stats$X3PAr.x_Difference <- Matchups_201617_With_Stats$X3PAr.x - Matchups_201617_With_Stats$X3PAr.y;
Matchups_201617_With_Stats$FTr.x_Difference <- Matchups_201617_With_Stats$FTr.x - Matchups_201617_With_Stats$FTr.y;
Matchups_201617_With_Stats$Pace_Difference <- Matchups_201617_With_Stats$Pace.x - Matchups_201617_With_Stats$Pace.y;
Matchups_201617_With_Stats$Overall_SOS_Difference <- Matchups_201617_With_Stats$Overall_SOS.x - Matchups_201617_With_Stats$Overall_SOS.y;


# Creating our model to help determine what statistical categories help predict which team wins
# This is the command which creates the logistic regression model using the below predictor variables

# Our baseline model
logit_model <- glm(Team_A_Won ~ Block_Percentage_Difference, data = Matchups_201617_With_Stats, family = "binomial");
summary(logit_model);

# Our best found model (From Ty)
logit_model2 <- glm(Team_A_Won ~ Overall_SOS_Difference + Pace_Difference + FTr.x_Difference + X3PAr.x_Difference + ORtg_Difference + True_Shooting_Percentage_Difference + True_Rebound_Percentage_Difference + Steal_Percentage_Difference + TO_Percentage_Difference + Block_Percentage_Difference, data = Matchups_201617_With_Stats, family = "binomial");
summary(logit_model2);

# Here we will create a data frame that will hold the matchups for 17-18, as well as the season-long statistics for the two teams in the matchup
Matchups_201718_With_Stats <- merge(Matchups_201718, Season_Stats_201718, by.x=c("Team_A_ID"), by.y=c("School_ID"));
Matchups_201718_With_Stats <- merge(Matchups_201718_With_Stats, Season_Stats_201718, by.x=c("Team_B_ID"), by.y=c("School_ID"));

# Create columns that compare statistical categories between two teams for the 2017-18 year
Matchups_201718_With_Stats$ORtg_Difference <- Matchups_201718_With_Stats$ORtg.x - Matchups_201718_With_Stats$ORtg.y;
Matchups_201718_With_Stats$True_Shooting_Percentage_Difference <- Matchups_201718_With_Stats$True_Shooting_Percentage.x - Matchups_201718_With_Stats$True_Shooting_Percentage.y;
Matchups_201718_With_Stats$True_Rebound_Percentage_Difference <- Matchups_201718_With_Stats$True_Rebound_Percentage.x - Matchups_201718_With_Stats$True_Rebound_Percentage.y;
Matchups_201718_With_Stats$Steal_Percentage_Difference <- Matchups_201718_With_Stats$Steal_Percentage.x - Matchups_201718_With_Stats$Steal_Percentage.y;
Matchups_201718_With_Stats$TO_Percentage_Difference <- Matchups_201718_With_Stats$TO_Percentage.x - Matchups_201718_With_Stats$TO_Percentage.y;
Matchups_201718_With_Stats$Block_Percentage_Difference <- Matchups_201718_With_Stats$Block_Percentage.x - Matchups_201718_With_Stats$Block_Percentage.y;
Matchups_201718_With_Stats$X3PAr.x_Difference <- Matchups_201718_With_Stats$X3PAr.x - Matchups_201718_With_Stats$X3PAr.y;
Matchups_201718_With_Stats$FTr.x_Difference <- Matchups_201718_With_Stats$FTr.x - Matchups_201718_With_Stats$FTr.y;
Matchups_201718_With_Stats$Pace_Difference <- Matchups_201718_With_Stats$Pace.x - Matchups_201718_With_Stats$Pace.y;
Matchups_201718_With_Stats$Overall_SOS_Difference <- Matchups_201718_With_Stats$Overall_SOS.x - Matchups_201718_With_Stats$Overall_SOS.y;

# Testing our baseline model
# This created a new column with a prediction of the probability that Team A Wins (1) or Loses (0)
Matchups_201718_With_Stats$Team_A_logit_prediction <- predict(logit_model, Matchups_201718_With_Stats, type="response");

# Using the probabality created above, make the guess of whether Team A Wins (1) or Loses(0)
Matchups_201718_With_Stats$Team_A_Logit_Model_Predict <- ifelse(Matchups_201718_With_Stats$Team_A_logit_prediction >= 0.5, 1, 0);

#Bring the library for the function below used to compare the actual game results with our prediction results
library(expss)

# Output the results of our logistic regression predictions versus the actual Team A game results
cro(Matchups_201718_With_Stats$Team_A_Won, Matchups_201718_With_Stats$Team_A_Logit_Model_Predict);

# Our best Logit Model (From Ty)
Matchups_201718_With_Stats$Team_A_logit_prediction2 <- predict(logit_model2, Matchups_201718_With_Stats, type="response");
Matchups_201718_With_Stats$Team_A_Logit_Model_Predict2 <- ifelse(Matchups_201718_With_Stats$Team_A_logit_prediction2 >= 0.5, 1, 0);
cro(Matchups_201718_With_Stats$Team_A_Won, Matchups_201718_With_Stats$Team_A_Logit_Model_Predict2);


# Export the data frame to CSV files for comparison outside of R, in Excel
write.csv(Matchups_201617_With_Stats,file="Matchups_201617_With_Stats.csv", row.names=FALSE);

write.csv(Matchups_201718_With_Stats,file="Matchups_201718_With_Stats.csv", row.names=FALSE);




