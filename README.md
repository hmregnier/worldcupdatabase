# World Cup Database
Certification task for freeCodeCamp [Relational Databases](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database).

## Files:
- worldcup.sql
- insert_data.sh
- queries.sh

### worldcup.sql
Code to create the database. Contains two tables:
- teams (team_id, name)
- games (game_id, winner_id, opponent_id, winner_goals, opponent_goals, year, round)

**Note:** *the columns* winner_id *and* opponent_id *reference the column* team_id.

### insert_data.sh
This is file used to insert all data currently in the database using a .csv file provided by freeCodeCamp. Some lines of code were provided and these can be indentified as those prior to the first comment.

### queries.sh
Code to query the database. Some code was provided by freeCodeCamp, setting up the PSQL variable and the echos that described the requirements of each query. My code consists of the queries themselves.
  
