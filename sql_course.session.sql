--time zones
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
LIMIT 5;

--EXTRACT MONTH
SELECT 
    COUNT (job_id),
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' 
GROUP BY 
    date_month
ORDER BY COUNT(job_id) DESC
;

--EXTRACT MONTH
SELECT * 
FROM job_postings_fact 
WHERE EXTRACT (MONTH FROM job_posted_date) = 1
LIMIT 10; 

--CASE (IF STATEMENT pod SELECT)
SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New Tork, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS category
FROM job_postings_fact;


--INNER JOIN - Croatia Data Analyst jobs
SELECT 
    company_dim.name,
    job_postings_fact.company_id,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_work_from_home,
    job_postings_fact.job_via,
    job_postings_fact.job_posted_date,
    job_postings_fact.job_title
FROM job_postings_fact
INNER JOIN Company_dim
ON job_postings_fact.company_id =Company_dim.company_id
WHERE job_postings_fact.job_location LIKE '%Croatia%' 
    AND job_postings_fact.job_title_short LIKE '%Data Analyst%'
LIMIT 1000;

SELECT *
FROM Company_dim
LIMIT 1000;

-- SubQuery - IN
SELECT 
    Company_id, 
    Name AS company_name 
FROM 
    company_dim 
WHERE company_id IN ( 
SELECT 
    Company_id,
    Job_no_degree_mention 
FROM 
    Job_postings_fact 
WHERE 
    Job_no_degree_mention = true 
    ORDER BY company_id
) 



SELECT
    COUNT (job_id) AS number_of_jobs,
    company_id
FROM
    job_postings_fact
GROUP BY    
    company_id;



-- RIGHT JOIN - number of DA jobs in Croatia
SELECT
    COUNT (job_postings_fact.job_id) AS number_of_jobs,
    company_dim.name,
    job_postings_fact.job_title
FROM
    job_postings_fact
RIGHT JOIN 
    company_dim
ON  
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_location LIKE '%Croatia%' 
GROUP BY    
     company_dim.name,
     job_postings_fact.job_title
ORDER BY number_of_jobs DESC;



--CTEs for number of remote jobs - WIP
WITH remote_jobs AS (
    SELECT 
        COUNT(job_work_from_home) AS remote_jobs_count
    FROM 
        job_postings_fact)
WITH skills AS (
    SELECT
        job_id,
        skill_id
    FROM
        skills_job_dim)
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    remote_jobs_count
FROM skills_dim
INNER JOIN remote_jobs
ON skills_dim.skill_id = skills.skill_id
INNER JOIN remote_jobs
ON remote_jobs.job_id = skills.job_id
ORDER BY remote_jobs_count DESC
;


-- all jobs above 70k for Q1 2023
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) IN (1,2,3)
    AND salary_year_avg IS NOT NULL
    AND salary_year_avg >70000
ORDER BY salary_year_avg 
;


SELECT *
FROM job_postings_fact
ORDER BY job_posted_date DESC
LIMIT 10000;

SELECT *
FROM job_postings_fact
LIMIT 100;