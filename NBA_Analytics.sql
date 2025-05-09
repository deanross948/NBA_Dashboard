select * from nba_cleaned;

CREATE OR REPLACE VIEW reg_season AS
SELECT 
    PLAYER_ID,
    PLAYER,
    TEAM,
    Season_start,
    PTS AS reg_pts,
    FG_PCT AS reg_fg_pct,
    EFF AS reg_eff,
    GP AS reg_gp
FROM nba_cleaned
WHERE SEASON_TYPE = 'Regular Season';

CREATE OR REPLACE VIEW playoffs AS
SELECT 
    PLAYER_ID,
    PLAYER,
    TEAM,
    Season_start,
    PTS AS po_pts,
    FG_PCT AS po_fg_pct,
    EFF AS po_eff,
    GP AS po_gp
FROM nba_cleaned
WHERE SEASON_TYPE = 'Playoffs';

CREATE OR REPLACE VIEW player_improvement AS
SELECT 
    r.PLAYER_ID,
    r.PLAYER,
    r.Season_start,
    r.TEAM,
    r.reg_pts,
    p.po_pts,
    (p.po_pts - r.reg_pts) AS pts_diff,
    r.reg_fg_pct,
    p.po_fg_pct,
    (p.po_fg_pct - r.reg_fg_pct) AS fg_pct_diff,
    r.reg_eff,
    p.po_eff,
    (p.po_eff - r.reg_eff) AS eff_diff
FROM reg_season r
JOIN playoffs p ON r.PLAYER_ID = p.PLAYER_ID AND r.Season_start = p.Season_start;

