DELETE FROM Flight
WHERE src = "SBA" AND dest = "ORD";

SELECT flightno AS flight_no, src AS source, dest AS destination FROM Flight;