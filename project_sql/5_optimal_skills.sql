/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles
-- Use Query #3


WITH demanded_skills AS(
    SELECT 
        skills_dim.skill_id,
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
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
    --AND job_country LIKE '%Croatia%'
    GROUP BY skills, skills_dim.skill_id
),
paying_skills AS(
    SELECT 
        skills_dim.skill_id,
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
    AND job_work_from_home = True
    --AND job_country LIKE '%Croatia%'
    GROUP BY skills, skills_dim.skill_id
)
SELECT
    skills_count,
    average_salary,
    demanded_skills.skills,
    demanded_skills.skill_id
FROM demanded_skills
INNER JOIN paying_skills
ON demanded_skills.skill_id = paying_skills.skill_id
WHERE skills_count > 10
ORDER BY 
    average_salary DESC,
    skills_count DESC 
;





