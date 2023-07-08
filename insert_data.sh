cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
	# check line is NOT headings in order to proceed
	if [[ $WINNER != "winner" ]]
	then
		# get winning team id
		WINNING_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
		# if empty
		if [[ -z $WINNING_TEAM_ID ]]
		then
			# insert new team
			INSERT_WINNING_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
			if [[ $INSERT_WINNING_TEAM_RESULT == "INSERT 0 1" ]]
			then
				echo Inserted into teams, $WINNER
			fi
			# get new winning team id
			WINNING_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
		fi
		# get opposing team id
		OPPOSING_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
		if [[ -z $OPPOSING_TEAM_ID ]]
		then
			# insert new team
			INSERT_OPPOSING_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
			if [[ $INSERT_OPPOSING_TEAM_RESULT == "INSERT 0 1" ]]
			then
				echo Inserted into teams, $OPPONENT
			fi
			# get new opposing team id
			OPPOSING_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
		fi
		# get game id
		GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNING_TEAM_ID' AND opponent_id='$OPPOSING_TEAM_ID'")
		# if game id is empty
		if [[ -z $GAME_ID ]]
		then
			# insert new game
			INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNING_TEAM_ID', '$OPPOSING_TEAM_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')")
			if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
			then
				echo Inserted into games, $WINNER_GOALS - $OPPONENT_GOALS match between $WINNER and $OPPONENT in $YEAR $ROUND
			fi
			
		fi
	fi
done
