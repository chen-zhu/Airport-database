SELECT Employee.name 
FROM certified 
JOIN Employee ON Employee.ssn = certified.ssn 
GROUP BY certified.ssn
HAVING COUNT(DISTINCT model_no) = (SELECT count(model_no) FROM Model);