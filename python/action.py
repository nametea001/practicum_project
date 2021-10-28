from sql import login_user, get_garage_from_userid,get_garage_from_id, update_garage 

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
    if(data[0]['status'] == "OCCUPIED" and data[0]['user_id'] != "0"):
        return None
    else:
        return data



