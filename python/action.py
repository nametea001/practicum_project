from sql import login_user, get_garage_from_userid, get_garage_from_id, update_garage, check_open

from practicum import find_mcu_boards, McuBoard, PeriBoard

import multiprocessing as mp
import time


# ------------------ get data ------------------------------

def check_login(user):
    data = login_user(user)
    return data


def get_garage(userId):
    data = get_garage_from_userid(userId)
    return data

# --------------------- update data -----------------


def update_garage_action(garageId, status):
    update_garage(garageId, status)
    data = get_garage_from_id(garageId)
    return data

def check_garage_open_action(userId, password):
    data = check_open(userId,password)
    return data


# ---------------------- check scan -----------
def check_garage(garageId):
    data = get_garage_from_id(garageId)
    if(data[0]['status'] == "OCCUPIED"):
        return None
    else:
        return data

# ---------------------- check scan -----------
def get_garage_from_id_action(garageId):
    data = get_garage_from_id(garageId)
    return data

# -------------- Open garage -----------------
def open_garage(garageId):
    if(garageId == "1"):
        peri.set_servo_1_open()
        time.sleep(5)
        d1 = check_distance_1()
        time.sleep(0.2)
        d3 = check_distance_3()
        time.sleep(0.2)
        if(d1 <=3 and d3 <=4):
            peri.set_servo_1_close()
        d1 = check_distance_1()
        d3 = check_distance_3()
        if(d1 >=6 and d3 >=5):
            peri.set_servo_1_close()

    elif(garageId == "2"):
        peri.set_servo_2_open()
        time.sleep(5)
        d2 = check_distance_2()
        time.sleep(0.2)
        d4 = check_distance_4()
        time.sleep(0.2)
        if(d2 <=3 and d4 <=4):
            peri.set_servo_1_close()
        d2 = check_distance_2()
        d4 = check_distance_4()
        if(d2 >=6 and d4 >=5):
            peri.set_servo_2_close()
            return 0
        
        return 0
# ------------- Close garage -----------


def close_garage(garageId):
    if(garageId == "1"):
        peri.set_servo_1_close()
        d1 = check_distance_1()
        time.sleep(0.5)
        d3 = check_distance_3()
        

    elif(garageId == "2"):
        peri.set_servo_2_close()
        d2 = check_distance_2()
        time.sleep(0.5)
        d4 = check_distance_4()
            
        return 0
    

def check_distance_1():
    distance = peri.read_distance_1()
    return distance

def check_distance_2():
    distance = peri.read_distance_2()
    return distance  

def check_distance_3():
    distance = peri.read_distance_3()
    return distance

def check_distance_4():
    distance = peri.read_distance_4()
    return distance        



devices = find_mcu_boards()
mcu = McuBoard(devices[0])
peri = PeriBoard(mcu)



