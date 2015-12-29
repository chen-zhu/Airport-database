SELECT avg(salary) AS avg_salary FROM Employee
JOIN Pilot ON Employee.ssn = Pilot.ssn;