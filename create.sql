DROP DATABASE IF EXISTS airport;
CREATE DATABASE airport;
USE airport;

CREATE TABLE TicketPurchase(
  tid INTEGER(10),
  customer_name CHAR(50),
  flight_no CHAR(10),
  date TIMESTAMP,
  PRIMARY KEY(tid)
);


CREATE TABLE Employee(
	name VARCHAR(40), 
	ssn VARCHAR(20), 
	phone VARCHAR(20), 
	addr VARCHAR(80), 
	union_no VARCHAR(20),
	salary INTEGER,
	PRIMARY KEY(ssn) 
); 

 
CREATE TABLE Traffic_control(
	ssn VARCHAR(20),  
	exam_date DATE,  
	PRIMARY KEY (ssn),  
	FOREIGN KEY (ssn) REFERENCES Employee(ssn) ON DELETE CASCADE 
); 


CREATE TABLE Technician(
	ssn VARCHAR(20),  
	PRIMARY KEY (ssn), 
	FOREIGN KEY (ssn) REFERENCES Employee(ssn) ON DELETE CASCADE
); 


CREATE TABLE Pilot(
	ssn VARCHAR(20), 
	PRIMARY KEY (ssn), 
	FOREIGN KEY (ssn) REFERENCES Employee(ssn) ON DELETE CASCADE
); 

CREATE TABLE Flight(
	flightno VARCHAR(40), 
	src VARCHAR(10), 
	dest VARCHAR(10), 
	arrival TIMESTAMP, 
	depart TIMESTAMP, 
	PRIMARY KEY(flightno)
); 


CREATE TABLE flies(
	ssn VARCHAR(20), 
	flightno VARCHAR(40), 
	PRIMARY KEY (ssn, flightno), 
	FOREIGN KEY(ssn) REFERENCES Pilot(ssn) ON DELETE CASCADE, 
	FOREIGN KEY(flightno) REFERENCES Flight(flightno) ON DELETE CASCADE
); 

CREATE TABLE Model(
	model_no VARCHAR(20), 
	weight INTEGER, 
	capacity INTEGER, 
	PRIMARY KEY(model_no)
); 

CREATE TABLE certified(
	expiry DATE, 
	ssn VARCHAR(20), 
	model_no VARCHAR(20), 
	FOREIGN KEY(ssn) REFERENCES Pilot(ssn) ON DELETE CASCADE, 
	FOREIGN KEY(model_no) REFERENCES Model(model_no) ON DELETE CASCADE, 
	PRIMARY KEY(ssn, model_no)
);


CREATE TABLE expert(
	ssn VARCHAR(20), 
	model_no VARCHAR(20), 
	FOREIGN KEY(model_no) REFERENCES Model(model_no) ON DELETE CASCADE, 
	FOREIGN KEY(ssn) REFERENCES Technician(ssn) ON DELETE CASCADE, 
	PRIMARY KEY(ssn, model_no)
); 


CREATE TABLE Airplane(
	reg_no VARCHAR(10), 
	model_no VARCHAR(20) NOT NULL,
	FOREIGN KEY(model_no) REFERENCES Model(model_no) ON DELETE CASCADE, 
	PRIMARY KEY(reg_no)
); 


CREATE TABLE Test(
	FAA_no VARCHAR(20), 
	max_score INTEGER, 
	name VARCHAR(20),
	PRIMARY KEY(FAA_no)
); 

CREATE TABLE testing_event(
	reg_no VARCHAR(10), 
	FAA_no VARCHAR(10),
	ssn VARCHAR(20), 
	date TIMESTAMP, 
	hours INTEGER, 
	score INTEGER, 
	FOREIGN KEY(reg_no) REFERENCES Airplane(reg_no) ON DELETE CASCADE,
	FOREIGN KEY(FAA_no) REFERENCES Test(FAA_no) ON DELETE CASCADE,
	FOREIGN KEY(ssn) REFERENCES Technician(ssn) ON DELETE CASCADE,
	PRIMARY KEY(FAA_no, reg_no, ssn, date)
); 


CREATE TABLE Stage(
	name VARCHAR(20), 
	exp_time INTEGER, 
	FAA_no VARCHAR(10) NOT NULL, 
	PRIMARY KEY(name, FAA_no), 
	FOREIGN KEY(FAA_no) REFERENCES Test(FAA_no) ON DELETE CASCADE
); 





















