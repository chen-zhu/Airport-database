SELECT Employee.name, testing_event.FAA_no AS faa_no, avg(Exp_time.exp_time - testing_event.hours) AS avg_deviation 
FROM testing_event
JOIN Test On Test.FAA_no = testing_event.FAA_no
JOIN Employee ON Employee.ssn = testing_event.ssn
JOIN (	
		SELECT Test.FAA_no, sum(Stage.exp_time)/60 AS exp_time
		FROM Test 
		JOIN Stage ON Test.FAA_no = Stage.FAA_no 
		GROUP BY Test.FAA_no ) AS Exp_time 
ON Exp_time.FAA_no = testing_event.FAA_no 
GROUP BY testing_event.ssn, testing_event.FAA_no
;  