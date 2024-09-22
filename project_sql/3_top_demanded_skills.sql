/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/



SELECT 
    COUNT(skills) AS skills_count,
    skills
FROM skills_dim
INNER JOIN 
    skills_job_dim
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
INNER JOIN 
    job_postings_fact 
ON
    skills_job_dim.job_id = job_postings_fact.job_id
WHERE 
   job_title_short = 'Data Analyst' 
   --AND job_country LIKE '%Croatia%'
GROUP BY skills
ORDER BY skills_count DESC
LIMIT 5;