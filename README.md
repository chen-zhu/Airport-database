# Airport Database


1. A create.sql file that creates all of your tables. A minimal example file is provided for you. Make sure all possible constraints from the ER diagram are reflected into table definitions. If you can’t express a constraint from the ER diagram, write a short comment at the top of this file explaining why.

2. A data insert.py file that inserts values into your tables. We will provide most of the Python code for this but you will need to fill in the missing parts with your own ”INSERT” SQL statements to match the tables you created in step (1). We will also provide you with a set of CSV data files to insert into your database for testing. We will be grading your queries against this data.
To run the python script, open a Command Line or Command Prompt. Navigate to the directory containing the data insert.py file. Make sure that all the provided data CSV files are in the same directory. Then run the command:
python data input.py

3. A single SQL file for each of the following queries. Name them a.sql, b.sql... etc. The order of the columns for the output for each query is described in parenthesis like so: (the, columns, should, be, in, this, order)
  - (a). Get the flight number, arrival time, and departure time of all flights flying either from, or to, LAX. (flight no, arrival, departure)
  
  - (b). Find the average salary of the pilots. (avg salary)
  
  - (c). Get the SSN, union number, and exam date, for all traffic controllers. (ssn, union no, exam date)
  
  - (d). Get the FAA number, test name, and max score, of all tests that have a ’Refuel’ stage. (faa no, name, max score)
  
  - (e). Get the FAA number, test name, and date of all the testing events that scored the max score. (faa no, name, date)
  
  - (f). Get the names of pilots certified to fly every airplane model. (name)
  
  - (g). Get the average number of airplane models that pilots are certified to fly. (aver- age )
  
  - (h). For all pilots with a salary of over $100,000, get their name and how many models they are certified to fly. (name, num certified)
  
  - (i). Give the pilots in (f) a 10% raise. Then output their names and their new salary. (name, salary)
  
  - (j). Delete all flights from Santa Barbara to Chicago. Then output all the flight number, source, and destination of the remaining flights. (flight no, source, destination )
  
  - (k). Get the technician name, technician phone number, test name, and airplane registration number, for which a technician scored less than half the max score on a testing event. (name, phone, test name, reg no)
  
  - (l). Get the name, address, and phone number of the technician with the highest salary who is an expert at ’Boeing’ models. Assume an airplane’s model number always starts with the manufacturer name, i.e. ’Boeing-747’, ’Airbus-A300’. (name, address, phone)
  
  - (m). To better understand flight delays, you want to see how long a technician actually spends on a test compared to the expected completion time. To do that, you want to calculate the average deviation of completion time for each technician, on each test. The deviation is the ’expected completion time’ of a test minus the time it actually took to complete the test. For each technician, get the FAA test number and average deviation for every test they conducted. (name, faa no, avg deviation)
  
