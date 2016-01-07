SELECT Employee.name, Employee.addr AS address, Employee.phone FROM Technician 
JOIN Employee ON Technician.ssn = Employee.ssn
JOIN expert ON Technician.ssn = expert.ssn
WHERE salary = (
		SELECT max(Employee.salary) FROM airport.Technician
		JOIN Employee ON Technician.ssn = Employee.ssn
		JOIN expert ON Technician.ssn = expert.ssn
		WHERE model_no LIKE "Boeing%" 
)
GROUP BY Employee.ssn
;