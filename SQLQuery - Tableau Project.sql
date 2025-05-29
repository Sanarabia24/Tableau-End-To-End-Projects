

--Queries used for Tableau Project

--1.
--Global Numbers
Select SUM(cast(new_cases as int)) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(try_cast
(new_deaths as decimal))/SUM(try_cast(new_cases as decimal))*100 as DeathPercentage
from [Portfolio Project]..[Covid Deaths]
Where continent is not NULL

--2.
--Total Death count by countries
Select location, SUM(Cast(new_deaths as int)) as TotalDeathCount
From [Portfolio Project]..[Covid Deaths]
Where continent is not NULL
--and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

--3.
--Total Death Count by Continent
Select continent, SUM(cast(new_deaths as int)) as TotalDeathCount
from [Portfolio Project]..[Covid Deaths]
where continent!=''
group by continent
order by  TotalDeathCount desc

--4.
--Highest Covid Infection Rate compared to Population by Countries
Select location, continent, population, Max(total_cases) as HighestInfectionCount, 
(CONVERT (float, Max(total_cases)) / NULLIF(CONVERT(float, Population), 0)) *100 as HighestInfectedPopulationPercent
from [Portfolio Project]..[Covid Deaths]
Group by location, continent, population
order by HighestInfectedPopulationPercent desc

--5.
--Highest Covid Infection Rate compared to Population by Countries and Date
Select location, population, FORMAT(CONVERT(DATE, date, 103), 'yyy-MM-dd') as datevalue, 
Max(total_cases) as HighestInfectionCount, 
(CONVERT (float, Max(total_cases)) / NULLIF(CONVERT(float, Population), 0)) *100 as HighestInfectedPopulationPercent
from [Portfolio Project]..[Covid Deaths]
Group by location, population, FORMAT(CONVERT(DATE, date, 103), 'yyy-MM-dd')
order by HighestInfectedPopulationPercent desc