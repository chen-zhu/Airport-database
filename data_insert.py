from __future__ import print_function
import csv
import sys

import mysql.connector

config = {
  'user': 'root',
  'password': '**********', 
  'host': '127.0.0.1', 
  'port': '3306', 
  'database': 'airport',
}

try:
  cnx = mysql.connector.connect(**config)
  cursor = cnx.cursor()
except mysql.connector.Error as err:
  print("Connection Error: {}".format(err))
  sys.exit(1)

def execute(query, values):
  your_query = query % values
  print("Executing: {} ... ".format(query % values), end="")
  try:
    cursor.execute(query, values)
  except mysql.connector.Error as err:
    print("ERROR\nMySQL Error: {}\n".format(err))
    sys.exit(1)
  else:
    print("Success")

def read_csv_file(filename, insert_function):
  try:
    f = open(filename, 'r')
  except IOError as err:
    print("I/O Error: {}".format(err))
    return

  reader = csv.DictReader(f)
  for row in reader:
    # Each row object here is a dictionary with the
    # column name as key and the values of the rows as values.
    # Ex: {'tid' : '1', 'customer_name' : 'Amr',  ... }
    insert_function(row)

# This converts a single string of space separated values into an array
# 'Boeing-747 Airbus-A300' -> ['Boeing-747', 'Airbus-A300']
def string_value_to_array(string_value):
  return string_value.split(' ')

# This converts a string of the form name:value into a tuple
# 'Refuel:35' -> ('Refuel', '35')
def string_value_to_tuple(string_value):
  return string_value.partition(':')[0::2]

def add_ticket_purchase_data(values):
  """Insert a row of ticket purchase data into the database"""
  insert_ticket_purchase = (
      "INSERT INTO TicketPurchase VALUES"
      "(%(tid)s, %(customer_name)s, %(flight_no)s, %(date)s)")
  execute(insert_ticket_purchase, values)

def add_employee_data(values):
  """Insert a row of employee data into the database"""
  insert_employee = (
      "INSERT INTO Employee VALUES"
      "(%(name)s, %(ssn)s, %(phone)s, %(addr)s, %(union_no)s, %(salary)s)")
  execute(insert_employee, values)

  job_title = values['job_title']
  if job_title == 'Technician':
    add_technician(values)
  elif job_title == 'Pilot':
    add_pilot(values)
  elif job_title == 'Traffic Controller':
    add_traffic_controller(values)

def add_airplane_data(values):
  """Insert a row of airplane data into the database"""
  insert_model = (
    "INSERT INTO Model VALUES"
      "(%(model_no)s, %(weight)s, %(capacity)s)")
  execute(insert_model, values)

  reg_no = string_value_to_array(values['registered_planes'])
  for i in reg_no:
    tmp={}
    tmp['reg_no'] = i
    tmp['model_no'] = values['model_no']
    insert_airplane = (
      "INSERT INTO Airplane VALUES"
        "(%(reg_no)s, %(model_no)s)")
    execute(insert_airplane, tmp)

    

def add_flights_data(values):
  """Insert a row of flight data into the database"""
  insert_flight = (
      "INSERT INTO Flight VALUES"
      "(%(flightno)s, %(src)s, %(dest)s, %(arrival)s, %(depart)s)")
  tmp = {}
  tmp['flightno']=values['flight_no']
  tmp['src']=values['src']
  tmp['dest']=values['dest']
  tmp['arrival']=values['arrival']
  tmp['depart']=values['depart']
  execute(insert_flight, tmp)
  insert_flies = (
    "INSERT INTO flies VALUES"
    "(%(ssn)s, %(flightno)s)")
  tmp = {}
  tmp['ssn']=values['pilot']
  tmp['flightno']=values['flight_no']
  execute(insert_flies, tmp)
  

def add_test_data(values):
  """Insert a row of test data into the database"""
  insert_test = (
    "INSERT INTO Test VALUES"
    "(%(FAA_no)s, %(max_score)s, %(name)s)")
  tmp = {}
  tmp['FAA_no'] = values['faa_no']
  tmp['max_score'] = values['max_score']
  tmp['name'] = values['test_name']
  execute(insert_test, tmp)
  #add statges here
  stage_array = string_value_to_array(values['stages'])
  for st in stage_array:
    tup = string_value_to_tuple(st)
    tmp = {}
    tmp['FAA_no'] = values['faa_no']
    tmp['name'] = tup[0]
    tmp['exp_time'] = tup[1]
    insert_stage = (
      "INSERT INTO Stage VALUES"
      "(%(name)s, %(exp_time)s, %(FAA_no)s)")
    execute(insert_stage, tmp)
  
  
  

def add_test_log_data(values):
  """Insert a row of test log data into the database"""
  insert_log = (
    "INSERT INTO testing_event VALUES"
    "(%(reg_no)s, %(FAA_no)s, %(ssn)s, %(date)s, %(hours)s, %(score)s)")
  tmp = {}
  tmp['reg_no'] = values['reg_no']
  tmp['FAA_no'] = values['faa_no']
  tmp['ssn'] = values['tech_ssn']
  tmp['date'] = values['date']
  tmp['hours'] = values['hours']
  tmp['score'] = values['score']
  execute(insert_log, tmp)
  

#----------------------------------------------------------
# helper functions for add_employee_data()
#----------------------------------------------------------
def add_pilot(values):
  insert_ssn = (
    "INSERT INTO Pilot VALUES"
      "(%(ssn)s)")
  tmp={}
  tmp['ssn'] = values['ssn']
  execute(insert_ssn, tmp)
  certifications = string_value_to_array(values['certifications'])
  for model_no in certifications:
    tup = string_value_to_tuple(model_no)
    insert_model = (
      "INSERT INTO certified VALUES"
      "(%(expiry)s, %(ssn)s, %(model_no)s)")
    tmp={}
    tmp['expiry'] = tup[1]
    tmp['ssn']=values['ssn']
    tmp['model_no'] = tup[0]
    execute(insert_model, tmp)
    

def add_technician(values):
  insert_ssn = (
    "INSERT INTO Technician VALUES"
      "(%(ssn)s)")
  tmp={}
  tmp['ssn'] = values['ssn']
  execute(insert_ssn, tmp)
  expertise = string_value_to_array(values['expertise'])
  for model_no in expertise:
    insert_model = (
      "INSERT INTO expert VALUES"
      "(%(ssn)s, %(model_no)s)")
    tmp={}
    tmp['ssn'] = values['ssn']
    tmp['model_no'] = model_no
    execute(insert_model, tmp)
    

def add_traffic_controller(values):
     insert_model = (
      "INSERT INTO Traffic_control VALUES"
      "(%(ssn)s, %(exam_date)s)")
     execute(insert_model, values)

if __name__ == '__main__':
  # Read data and insert.
  # These files need to be in the same directory as this python script.
  read_csv_file('ticket_purchase_data.csv', add_ticket_purchase_data)
  read_csv_file('airplane_data.csv', add_airplane_data)
  read_csv_file('employee_data.csv', add_employee_data)
  read_csv_file('flights_data.csv', add_flights_data)
  read_csv_file('test_data.csv', add_test_data)
  read_csv_file('test_log_data.csv', add_test_log_data)

  # Commit data
  cnx.commit()

  cursor.close()
  cnx.close()
