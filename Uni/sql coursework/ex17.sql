SELECT casesAndDeaths.countriesAndTerritories AS country, 100*CAST(SUM(cases) AS FLOAT(3))/CAST(popData2018 AS FLOAT(3)) AS '% cases of population', 100*CAST(SUM(deaths) AS FLOAT(3))/CAST(popData2018 AS FLOAT(3)) AS '% deaths of population'
FROM casesAndDeaths
LEFT JOIN countries
ON casesAndDeaths.countriesAndTerritories = countries.countriesAndTerritories
LEFT JOIN countryData
ON countries.dataKey = countryData.dataKey
GROUP BY countries.countriesAndTerritories;