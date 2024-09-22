/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS average_salary
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
   AND salary_year_avg IS NOT NULL
   --AND job_work_from_home = True
   --AND job_country LIKE '%Croatia%'
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;