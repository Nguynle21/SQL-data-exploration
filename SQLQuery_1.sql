--Selecting Data that we are going to be using
Select location, date, population, total_cases, total_deaths
from master.dbo.Covid_Deaths
order by 1,2;

--Showing the total cases vs the population
Select location, date, population, total_cases, (total_cases/population)*100 as casepercentage
from Covid_Deaths
order by 1,2;

--Ranking the months by total cases in the U.S. in 2020
Select [location], month(date) as month, sum(new_cases) as totalcases
from Covid_Deaths
where continent is not NULL
group by location, MONTH(date)
having location ='United States'
order by sum(new_cases) DESC;

--Ranking the countries by total cases each year
Select [location], year(date) as year, sum(new_cases) as totalcases
from Covid_Deaths
where continent is not NULL
group by location, year(date)
order by year, sum(new_cases) DESC;

--Ranking Asian countries by most deaths in one month in 2020
With CTE_Asia as
(Select [location], month(date) as month, sum(new_deaths) as totaldeaths
from Covid_Deaths
where continent = 'Asia' and year(date) = 2020
group by location, month(date)
)
Select location, max(totaldeaths) as highest_month
from CTE_Asia
group by location
order by 2 DESC;

--Showing the total vaccinations vs population
Select dea.[location], dea.date, population, (total_vaccinations/population)*100 as vaccine_percentage
from Covid_Deaths as dea
join Covid_Vaccinations as vac 
on dea.[location] = vac.[location] and dea.date = vac.date
order by 1,2; 
