/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/


WITH top_10_DA AS (
SELECT 
    job_id,
    job_title,
    name AS company_name,
    salary_year_avg,
    job_country,
    job_schedule_type
FROM   
    job_postings_fact
LEFT JOIN company_dim
ON company_dim.company_id = job_postings_fact.company_id
WHERE 
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
ORDER BY 
    salary_year_avg DESC
LIMIT 10
)
SELECT 
    top_10_da.*,
    skills
FROM top_10_DA 
INNER JOIN skills_job_dim
ON top_10_DA.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
;

