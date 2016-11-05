a = 1
b = 2
import numpy as np


c = a / 2
list2 = [x * 2 for x in np.arange(33, 44)]

print(c)

d = x if c > 2 else 3
print(d)
print(list2)


for i in np.arange(1, 2):

    print(i * i)

    print("------------")


aa = np.array([1, 2])


print("計算")

print(np.dot(aa.T, aa))
