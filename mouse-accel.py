import math
dx = 0.1
start_slope = 1
accel = 4
x = 0
y = 0
max_scale_factor = 12

print(dx, end=" ")

while True:
    if start_slope + x*accel > max_scale_factor: break
    y = start_slope*x + accel*math.pow(x,2)/2
    print(round(y, 3), end=" ")
    x += dx
print()