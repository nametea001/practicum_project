import mysql.connector

import datetime

def connext_db():
  mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="smart_garage"
  )
  return mydb


# -------------------- map data -------------------------
def map_data_login(data):
  user = {
          "id":str(data[0]),
          "username":data[1]
          }
  return user

def map_data_user(data):
  user = {
          "id":str(data[0]),
          "username":data[1],
          "first_name":data[3],
          "last_name":data[4],
          "locale":data[5]
          }
  return user

def map_data_garage(data):
  garage = {
    "id":str(data[0]),
    "name":data[1],
    "user_id":str(data[2]),
    "status":data[3],
    "parking_date":data[4],
  }
  return garage

# ------------------ get data ------------------------------

def login_user(user):
  mydb = connext_db()
  mycursor = mydb.cursor()
  select = "SELECT * FROM users Where (username = '{}' and password = '{}')".format(user.username,user.password)
  mycursor.execute(select)
  myresult = mycursor.fetchone()
  if(myresult):
    row = map_data_login(myresult)
    return row
  else:
    return None

def get_garage_from_id(gId):
  mydb = connext_db()
  mycursor = mydb.cursor()
  select =  "SELECT * FROM garages Where id = '{}' ".format(gId)
  mycursor.execute(select)
  myresult = mycursor.fetchall()

  if(myresult):
    rows = []
    for x in myresult:
      row = map_data_garage(x)
      rows.append(row)
    return rows
  else:
    return None

def get_garage_from_userid(userId):
  mydb = connext_db()
  mycursor = mydb.cursor()
  select =  "SELECT * FROM garages Where user_id = '{}' ".format(userId)
  mycursor.execute(select)
  myresult = mycursor.fetchall()

  if(myresult):
    rows = []
    
    for x in myresult:
      row = map_data_garage(x)
      rows.append(row)
    return rows
  else:
    return None

def update_garage(garageId, status):
  mydb = connext_db()
  mycursor = mydb.cursor()
  dateNow = datetime.datetime.now()

  update = "UPDATE garages SET status = '{}', parking_date = '{}' Where id = '{}'".format(status, dateNow, garageId)
  mycursor.execute(update)
  mydb.commit()


