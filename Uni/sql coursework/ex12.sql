INSERT INTO date
(dateRep, day, month, year)
SELECT DISTINCT dateRep, day, month, year FROM dataset;

INSERT INTO countryData
(geoId, countryterritoryCode, popData2018)
SELECT DISTINCT geoId, countryterritoryCode, popData2018 FROM dataset;

INSERT INTO countries
(countriesAndTerritories, continentExp, dataKey)
SELECT DISTINCT countriesAndTerritories, continentExp , dataKey
FROM dataset
LEFT JOIN countryData
ON dataset.geoId=countryData.geoId;

INSERT INTO casesAndDeaths
(dateRep, countriesAndTerritories, cases, deaths)
SELECT dateRep, countriesAndTerritories, cases, deaths FROM dataset;