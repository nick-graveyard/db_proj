1,2)
SELECT job_code, title, person_id, pay_type, pay_rate
FROM job NATURAL JOIN position 
WHERE company_id = ? and ( ? = 'ALL' or pay_type = ? )

3)
SELECT company_name, title AS pos_title, company_id, job_code, pay_rate, pay_type 
FROM company NATURAL JOIN job NATURAL JOIN position
WHERE person_id = ?

4)
SELECT person_id
FROM project_job WHERE project_id = ?

5)
a)
SELECT title, description, ks_level 
FROM person_k_skills NATURAL JOIN knowledge_skill
WHERE person_id = ?

b)
SELECT cert_name, exp_date 
FROM credentials NATURAL JOIN certificate
WHERE person_id = ?


6,7)
a)
SELECT title, description, ks_level 
FROM knowledge_skill 
WHERE ks_code IN (SELECT ks_code FROM job NATURAL JOIN position_required_skill WHERE job_code = ?
		MINUS
		SELECT ks_code FROM person_k_skills WHERE person_id = ?)

b)
SELECT cert_name,null AS exp_date 
FROM certificate WHERE cert_code IN (SELECT cert_code FROM position_certificate NATURAL JOIN job WHERE job_code = ?
				    MINUS
				    SELECT cert_code FROM credentials WHERE person_id = ?)
				    
				    
11,12)
WITH test1 (position_code) AS
    (SELECT position_code FROM position p
    WHERE NOT EXISTS (SELECT ks_code FROM position_required_skill ps
    			WHERE p.position_code = ps.position_code
    			MINUS
    			SELECT ks_code FROM person_k_skills
    			WHERE person_id = ? )
    	AND NOT EXISTS (SELECT cert_code FROM position_certificate pc
    			WHERE p.position_code = pc.position_code
    			MINUS
    			SELECT cert_code FROM credentials
    			WHERE person_id = ?)),
    test2 (job_code, annualpay) AS
    ((SELECT job_code, pay_rate as annualpay
    FROM job NATURAL JOIN test1
    WHERE pay_type = 'salary')
    UNION
    (SELECT job_code, (pay_rate*num_hours*12) AS annualpay
    FROM job NATURAL JOIN test1
    WHERE pay_type = 'wage'))
    
    SELECT company_name, title AS pos_title, company_id, job_code, pay_rate, pay_type
    FROM company NATURAL JOIN job NATURAL JOIN position NATURAL JOIN test2
    ORDER BY annualpay
    
    
13,14)
WITH JOB_REQUIRED_SKILL (ks_code) AS
(SELECT ks_code FROM position_required_skill natural join job WHERE job_code = ?),

PERSON_NUM_SKILL (person_id, num_skill) AS
(SELECT person_id, count(ks_code) FROM JOB_REQUIRED_SKILL natural join person_k_skills
GROUP BY person_id
ORDER BY count(ks_code) desc)

SELECT person_id,num_skill from PERSON_NUM_SKILL
where (? = 'qualified' AND num_skill = (select count(ks_code) from JOB_REQUIRED_SKILL))
	OR (? != 'qualified' AND rownum <= ?)";
	
