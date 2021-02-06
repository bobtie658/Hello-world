SELECT casesAndDeaths.dateRep AS date, cases AS 'number of cases'
FROM casesAndDeaths
LEFT JOIN date
ON casesAndDeaths.dateRep=date.dateRep
WHERE countriesAndTerritories = 'United_Kingdom'
ORDER BY year ASC, month ASC, day ASC;