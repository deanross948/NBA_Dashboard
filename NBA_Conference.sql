CREATE OR REPLACE VIEW NBA_DATA AS
SELECT 
  *,
  CASE
    WHEN TEAM IN ('BOS', 'PHI', 'MIA', 'MIL', 'ATL', 'NYK', 'CHI', 'CLE', 'BKN', 'IND', 'ORL', 'TOR', 'CHA', 'WAS', 'DET') THEN 'East'
    WHEN TEAM IN ('LAL', 'GSW', 'PHX', 'DEN', 'DAL', 'SAC', 'MEM', 'LAC', 'NOP', 'MIN', 'HOU', 'OKC', 'SAS', 'UTA', 'POR') THEN 'West'
    ELSE 'Unknown'
  END AS Conference,
  CASE 
        WHEN (FGA + 0.44 * FTA) = 0 THEN NULL
        ELSE ROUND(PTS / (2 * (FGA + 0.44 * FTA)),4)
	END AS TS_PCT
FROM nba_cleaned
WHERE SEASON_START > 2019;

/*ADD COLUMN TS_PCT DECIMAL(5,4) GENERATED ALWAYS AS (
    CASE 
        WHEN (FGA + 0.44 * FTA) = 0 THEN NULL
        ELSE PTS / (2 * (FGA + 0.44 * FTA))
    END
) STORED;*/



