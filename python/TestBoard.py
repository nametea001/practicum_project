from typing import Any 
from practicum import find_mcu_boards, McuBoard, PeriBoard
import time
devices = find_mcu_boards()
mcu = McuBoard(devices[0])
peri = PeriBoard(mcu)


# x = peri.set_servo_1_open()
# print(x)
# time.sleep(6)

# d1 = peri.read_distance_2()
# print(d1)
# time.sleep(0.5)
# d3 = peri.read_distance_4()
# print(d3)

# if(d1 <= 3 and d3 <=4):
#     x = peri.set_servo_1_close()

# d1 = peri.read_distance_1()
# print(d1)
# time.sleep(0.5)
# d3 = peri.read_distance_3()
# print(d3)   

# if(d1 >= 6 and d3 >= 5):
#     x = peri.set_servo_1_close()

    
y = peri.set_servo_2_open()
print(y)
time.sleep(6)

d2 = peri.read_distance_2()
print(d2)
time.sleep(0.5)
d4 = peri.read_distance_4()
print(d4)

if(d2 <= 3 and d4 <=4):
    x = peri.set_servo_2_close()

d2 = peri.read_distance_2()
print(d2)
time.sleep(0.5)
d3 = peri.read_distance_4()
print(d4)   

if(d2 >= 6 and d4 >= 5):
    x = peri.set_servo_2_close()