SELECT casesAndDeaths.dateRep AS date, SUM(deaths)OVER(ORDER BY year,month,day) AS 'cumulative UK deaths', SUM(cases)OVER(ORDER BY year,month,day) AS 'cumulative UK cases'
FROM casesAndDeaths
LEFT JOIN date
ON casesAndDeaths.dateRep=date.dateRep
WHERE countriesAndTerritories = 'United_Kingdom'
ORDER BY year ASC, month ASC, day ASC;