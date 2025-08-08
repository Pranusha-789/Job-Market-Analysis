SELECT * FROM job_market.job_dataset;
use job_market;
select * from job_dataset;
DELIMITER $$

CREATE PROCEDURE analyze_job_market()
BEGIN
-- top 10 high paying job titles:
SELECT job_title, 
       ROUND(AVG(salary_usd), 2) AS avg_salary_title FROM job_dataset
GROUP BY job_title
ORDER BY avg_salary_title DESC
LIMIT 10;
 -- highest average salary countries wise
 select company_location,round(avg(salary_usd),2) as avg_salary_country
 from job_dataset group by company_location 
 order by avg_salary_country desc
 limit 10;
 -- count of jobs are listed by each company
 select company_name, count(*) as job_postings from job_dataset
 group by company_name
 order by job_postings desc
 limit 10;
 -- count of job are posted per industry
 select industry, count(*) as total_jobs from job_dataset
 group by industry order by total_jobs desc;
 -- remote(vs)onsite jobs
 select 
  case
  when remote_ratio=0 then 'on_site'
  when remote_ratio=50 then 'Hybrid'
  when remote_ratio=100 then 'Remote'
  else 'unknown'
end as work_type,
count(*) as job_count from job_dataset group by work_type;
-- experience_level most(count) job postings
select experience_level, count(*) as num_postings from job_dataset
group by experience_level
order by num_postings desc;
END$$

DELIMITER ;
CALL analyze_job_market();
