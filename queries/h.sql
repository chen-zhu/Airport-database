SELECT Employee.name, T.num_certified FROM Employee 
JOIN (
	SELECT ssn, count(*) as num_certified FROM certified 
	GROUP BY ssn) AS T 
ON Employee.ssn = T.ssn
WHERE Employee.salary>100000
;