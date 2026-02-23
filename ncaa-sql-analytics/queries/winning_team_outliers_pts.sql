-- Question:
-- Which teams win more than expected?
-- Point margin will be used as a proxy.

SELECT school,
	   wins,
       losses,
       win_pct,
       points_for,
       points_against,
       points_for - points_against AS points_margin
FROM cbb_stats.school_stats
WHERE wins > losses AND points_for - points_against < 0
ORDER BY points_margin DESC