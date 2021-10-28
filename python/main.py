from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
from action import check_login, get_garage, update_garage_action, check_garage


app = FastAPI()


# user
class User(BaseModel):
    username: Optional[str]
    password: Optional[str]


# ------------- routh ---------

@app.post("/api/login")
def api_login(user: User):
    data = check_login(user)
    if data:
        return {"user": data, "error": False}  
    else:
        return {"user": "Null", "error": True}

@app.get("/api/garage")
def api_garage_from_user_id(user_id):
    data = get_garage(user_id)
    if data:
        return {"garages": data, "error": False}
    else:
        return {"garages": "Null", "error": True}

@app.get("/api/check_garage/{garageId}")
def api_check_garage(garageId):
    data = check_garage(garageId)
    if data:
        return {"garages": data, "error": False}
    else:
        return {"garages": "Null", "error": True}

@app.post("/api/update_garage")
def api_update_garage(garageId, status):
    data = update_garage_action(garageId, status)
    if data:
        return {"garages": data, "error": False}
    else:
        return {"garages": "Null", "error": True}


 
if __name__ == '__main__':
    uvicorn.run(app, host='192.168.31.212', port=8000 )

