-- 1 . Remove Duplicates
-- 2 . Standerdize the Data
-- 3 . Null Values or blank values
-- 4 . Remove Any Columns
use world_layoffs2;
SELECT * from layoffs_staging;
select * , row_number() OVER(
partition by company ,industry , total_laid_off ,percentage_laid_off ,`date`
) AS row_num 
FROM layoffs_staging;





With dulicate_cte2 AS (
select * , row_number() OVER(
partition by company,location ,industry ,
 total_laid_off ,percentage_laid_off ,
 `date` , stage, country , funds_raised_millions
) AS row_num 

FROM layoffs_staging
)
SELECT *
FROM dulicate_cte2
WHERE row_num > 1;


select * from duplicate_cte
where row_num>1;
-- 'Casper', 'New York City', 'Retail', NULL, NULL, '9/14/2021', 'Post-IPO', 'United States', '339', '2'
-- 'Cazoo', 'London', 'Transportation', '750', '0.15', '6/7/2022', 'Post-IPO', 'United Kingdom', '2000', '2'
-- 'Hibob', 'Tel Aviv', 'HR', '70', '0.3', '3/30/2020', 'Series A', 'Israel', '45', '2'
-- 'Wildlife Studios', 'Sao Paulo', 'Consumer', '300', '0.2', '11/28/2022', 'Unknown', 'Brazil', '260', '2'
-- 'Yahoo', 'SF Bay Area', 'Consumer', '1600', '0.2', '2/9/2023', 'Acquired', 'United States', '6', '2'

SELECT * from layoffs_staging where company ='Terminus';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
select * , row_number() OVER(
partition by company,location ,industry ,
 total_laid_off ,percentage_laid_off ,
 `date` , stage, country , funds_raised_millions
) AS row_num 

FROM layoffs_staging;




SELECT * FROM layoffs_staging2;


SELECT * FROM layoffs_staging2
WHERE row_num>1
;
-- You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.00049 sec


SET SQL_SAFE_UPDATES = 0;
DELETE 
 FROM layoffs_staging2
WHERE row_num>1
;
SET SQL_SAFE_UPDATES = 1;




SELECT * FROM layoffs_staging2

;



-- Standerdize data


SELECT company,trim(ORDER BY 1
;
SET SQL_SAFE_UPDATES = 0;
UPDATE layoffs_staging2
SET company =trim(company);
SELECT distinct industry FROM layoffs_staging2
ORDER BY 1
;

select industry FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';
Update 
 layoffs_staging2
 SET industry ='Crypto'
WHERE industry LIKE 'Crypto%';



SELECT distinct country FROM layoffs_staging2
ORDER BY 1
;
Update 
 layoffs_staging2
 SET country ='United States'
WHERE country LIKE 'United States%';


Update 
 layoffs_staging2
 SET country =trim(TRAILING '.' FROM country )
;



-- change text to date

select `date` ,  str_to_date(`date` , '%m/%d/%Y') from layoffs_staging2;

UPDATE layoffs_staging2
SET  `date`= str_to_date(`date` , '%m/%d/%Y');

select `date`  from layoffs_staging2;



ALTER table layoffs_staging2
modify `date` DATE;


SELECT * FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;

SELECT * FROM layoffs_staging2;



SELECT * FROM layoffs_staging2
WHERE industry is null
OR industry ='';



SELECT * FROM layoffs_staging2
 WHERE  company ='Airbnb';




select * FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
On t1.company=t2.company
WHERE (t1.industry is NULL OR t1.industry= '')
AND t2.industry IS NOT null;



select t1.industry, t2.industry FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
On t1.company=t2.company
WHERE (t1.industry is NULL OR t1.industry= '')
AND t2.industry IS NOT null;




UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  SET t1.industry= t2.industry

WHERE (t1.industry is NULL OR t1.industry= '')
AND t2.industry IS NOT null;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;






SELECT * FROM layoffs_staging2
WHERE total_laid_off is null
AND percentage_laid_off is null;

-- remove columns
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;



