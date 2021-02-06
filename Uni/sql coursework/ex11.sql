CREATE TABLE casesAndDeaths(
  "dateRep" date
    constraint casesAndDeaths_date_dateRep_fk
      references date
        on update restrict on delete restrict,
  "countriesAndTerritories" varchar(255)
    constraint casesAndDeaths_countries_countriesAndTerritories_fk
      references countries
        on update restrict on delete restrict,
  "cases" integer,
  "deaths" integer
);

CREATE TABLE date(
  "dateRep" date
    constraint date_pk
      primary key not null,
  "day" integer not null,
  "month" integernot null,
  "year" integer not null
);

CREATE TABLE countries(
  "countriesAndTerritories" varchar(255)
    constraint countries_pk
      primary key not null,
  "dataKey" integer
    constraint countries_countryData_dataKey_fk
      references countryData
        on update cascade on delete cascade
          not null,
  "continentExp" varchar(255)
);

CREATE TABLE countryData(
  "dataKey" integer
    constraint countryData_pk
      primary key autoincrement,
  "geoId" varchar(255),
  "countryterritoryCode" varchar(3),
  "popData2018" integer
);