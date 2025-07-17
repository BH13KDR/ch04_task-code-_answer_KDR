import math

#삼각형 넓이
def triM(밑면, 높이):
    return 0.5 * 밑면 * 높이

#원의 넓이
def cirM(반지름):
    return math.pi * (반지름 ** 2)
    
#직육면체 넓이
def cubM(x, y, z):
    return 2 * (x*y + y*z + x*z)