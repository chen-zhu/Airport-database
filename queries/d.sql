SELECT Stage.FAA_no AS faa_no, Test.name, Test.max_score from Stage 
JOIN Test on Stage.FAA_no = Test.FAA_no
WHERE Stage.name = 'refuel'; 