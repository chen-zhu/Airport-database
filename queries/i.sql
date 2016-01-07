SET SQL_SAFE_UPDATES=0;

UPDATE Employee
SET Employee.salary = Employee.salary * 1.1 
WHERE Employee.ssn IN (SELECT certified.ssn  
		FROM certified 
		GROUP BY certified.ssn
		HAVING COUNT(DISTINCT model_no) = (SELECT count(model_no) FROM Model)
        ); 
        
SELECT Employee.name, Employee.salary
FROM certified 
JOIN Employee ON Employee.ssn = certified.ssn 
GROUP BY certified.ssn
HAVING COUNT(DISTINCT model_no) = (SELECT count(model_no) FROM Model);
        
        





