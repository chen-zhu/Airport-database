SELECT Traffic_control.ssn, Employee.union_no, Traffic_control.exam_date 
FROM Employee
JOIN Traffic_control 
ON Employee.ssn = Traffic_control.ssn;