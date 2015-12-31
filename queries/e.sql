Select Test.FAA_no AS faa_no, Test.name, testing_event.date FROM Test 
JOIN testing_event 
ON Test.FAA_no = testing_event.FAA_no
WHERE testing_event.score = Test.max_score;
