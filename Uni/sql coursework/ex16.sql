SELECT continentExp AS continent, casesAndDeaths.dateRep AS date, SUM(cases) AS 'number of cases', SUM(deaths) AS 'number of deaths'
FROM casesAndDeaths
LEFT JOIN countries
ON casesAndDeaths.countriesAndTerritories = countries.countriesAndTerritories
LEFT JOIN date
ON casesAndDeaths.dateRep = date.dateRep
GROUP BY continentExp, casesAndDeaths.dateRep
ORDER BY year ASC, month ASC, day ASC;