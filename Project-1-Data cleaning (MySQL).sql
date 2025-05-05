-- Data Cleaning

SELECT *
FROM layoffs;

-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null Values or blank values
-- 4. Remove any columns or rows

# create a staging table
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT  layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

-- 1 remove duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER( #create row number if >1 is duplicate
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging_2;

INSERT INTO layoffs_staging_2
SELECT *,
ROW_NUMBER() OVER( #create row number if >1 is duplicate
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging_2
WHERE row_num>1;

SELECT *
FROM layoffs_staging_2
WHERE row_num>1;

-- Standardizing Data

#trim the strings and update table
SELECT company, TRIM(company)
from layoffs_staging_2;

UPDATE layoffs_staging_2
SET company = TRIM(company);

#Check unique industries
SELECT DISTINCT industry
FROM layoffs_staging_2;

SELECT *
FROM layoffs_staging_2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging_2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location
FROM layoffs_staging_2
ORDER BY 1
;

SELECT DISTINCT country
FROM layoffs_staging_2
ORDER BY 1
;

UPDATE layoffs_staging_2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging_2;

UPDATE layoffs_staging_2
set `date`=str_to_date(`date`,'%m/%d/%Y');

SELECT `date`
FROM layoffs_staging_2;

#CHANGE DATA TYPE
ALTER TABLE layoffs_staging_2
MODIFY COLUMN `date` DATE;

-- NULL AND BLANK VALUES

SELECT *
FROM layoffs_staging_2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging_2
WHERE company = 'Airbnb';

#change blank values to null values
UPDATE layoffs_staging_2
SET industry= NULL
WHERE industry = '';

#See the Null values
SELECT t1.industry, t2.industry
FROM layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
	on t1.company=t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

#fill the Null values
UPDATE layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT t1.industry, t2.industry
FROM layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
	on t1.company=t2.company
    and t1.location=t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

#check other values
SELECT *
FROM layoffs_staging_2
WHERE industry IS NULL;

SELECT *
FROM layoffs_staging_2
WHERE company LIKE 'Bally%'; # only 1 row of Bally so we don't have any other row to check if we can substitute

#these rows we are unable to fill them if we had total employees we could calculate % and/or total laid off
#probably is better to delete the rows, but we need to be confident, probably there's no layoff
SELECT *
FROM layoffs_staging_2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Delete the rows
DELETE
FROM layoffs_staging_2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Delete the column row_num
ALTER TABLE layoffs_staging_2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging_2;

