SELECT Employee.name, Employee.phone, Test.name AS test_name, testing_event.reg_no 
FROM testing_event
JOIN Test ON Test.FAA_no = testing_event.FAA_no 
JOIN Employee ON Employee.ssn = testing_event.ssn 
WHERE testing_event.score < Test.max_score/2; 