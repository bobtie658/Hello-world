SELECT casesAndDeaths.countriesAndTerritories AS country, 100*(CAST((SUM(deaths)) AS FLOAT(3))/CAST(SUM(cases) AS FLOAT(3))) AS '% deaths of country cases'
FROM casesAndDeaths
GROUP BY casesAndDeaths.countriesAndTerritories
ORDER BY 100*(CAST((SUM(deaths)) AS FLOAT(3))/CAST(SUM(cases) AS FLOAT(3))) DESC
LIMIT 10;