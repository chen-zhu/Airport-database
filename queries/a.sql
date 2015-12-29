SELECT flightno AS flight_no, arrival, depart AS departure FROM airport.Flight 
WHERE src = "LAX" OR dest = "LAX"; 