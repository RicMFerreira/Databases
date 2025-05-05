-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging_2;

#
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging_2;

#Top 10 companies number of layoff of 100% laid off
SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC LIMIT 10;

#Top 10 companies funds raised of 100% laid off
SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC LIMIT 10;

#
SELECT company, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC
# OR ORDER BY 2 DESC
;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging_2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY stage
ORDER BY 2 DESC;

#running total
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging_2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging_2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,total_off, SUM(total_off) OVER(ORDER BY `MONTH`) as rolling_total
FROM rolling_total;

#per year
SELECT company, YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year(company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company, YEAR(`date`)
)
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
ORDER BY ranking ASC;


#Top 5 company per year total laid off
WITH company_year(company, years, total_laid_off) AS # CTE Group company layoff per per year
(
SELECT company, YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company, YEAR(`date`)
), company_year_rank as
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking # Assigns rankings based on layoffs per year
FROM company_year
WHERE years IS NOT NULL
)
SELECT * #Filters the top 5 layoffs per year
FROM company_year_rank
WHERE ranking <=5
;
