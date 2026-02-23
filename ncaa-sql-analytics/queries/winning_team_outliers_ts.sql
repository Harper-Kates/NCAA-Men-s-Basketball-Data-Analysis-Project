-- Question:
-- Which teams win often while shooting below average?

WITH generated_ts AS (
    SELECT
        school,
        wins,
        losses,
        win_pct,
        points_for / (2 * (fg_attempted + 0.44 * ft_attempted)) AS true_shooting
    FROM cbb_stats.school_stats
),
league_avg AS (
    SELECT AVG(true_shooting) AS avg_ts
    FROM generated_ts
)
SELECT
    g.school,
    g.wins,
    g.losses,
    g.win_pct,
    g.true_shooting,
    l.avg_ts,
    CAST(ROUND(g.true_shooting - l.avg_ts, 6)AS DECIMAL(10,6)) AS ts_margin
FROM generated_ts g
CROSS JOIN league_avg l
WHERE wins > losses AND g.true_shooting - l.avg_ts < 0
ORDER BY ts_margin DESC