from sql import login_user, get_garage_from_userid, get_garage_from_id, update_garage

from practicum import find_mcu_boards, McuBoard, PeriBoard

import multiprocessing as mp


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


# ---------------------- check scan -----------
def check_garage(garageId):
    data = get_garage_from_id(garageId)
    if(data[0]['status'] == "OCCUPIED"):
        return None
    else:
        return data


# -------------- Open garage -----------------
def open_garage(garageId):
    if(garageId == "1"):
        peri.set_servo_1_open()
        return 0
    elif(garageId == "2"):
        peri.set_servo_2_open()
        return 0
# ------------- Close garage -----------


def close_garage(garageId):
    if(garageId == "1"):
        peri.set_servo_1_close()
        return 0
    elif(garageId == "2"):
        peri.set_servo_2_close()
        return 0

def check_distance_1():
    distance = peri.read_distance_1()
    return distance/10



devices = find_mcu_boards()
mcu = McuBoard(devices[0])
peri = PeriBoard(mcu)



