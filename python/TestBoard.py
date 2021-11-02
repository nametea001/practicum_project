from practicum import find_mcu_boards, McuBoard, PeriBoard
import time
devices = find_mcu_boards()
mcu = McuBoard(devices[0])
peri = PeriBoard(mcu)

x = peri.read_distance_1()
print(x)
time.sleep(0.5)
x = peri.read_distance_2()
print(x)
# for i in x:
#     print(i)

