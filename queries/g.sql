SELECT avg(num_certified) AS average FROM 
(
SELECT ssn, count(*) as num_certified FROM certified 
GROUP BY ssn) AS T 
;
