import cmath
import matplotlib.pyplot as plt
import numpy as np

max = 1000
min = -max

j = complex(0, 1)
t = np.linspace(-6, 10, max)
ka = np.arange(min, max, 1)
x = 0.0
x0 = 0.0
x1 = 0.0
A = np.zeros(max - min)
f = np.zeros(max - min)
w = np.pi * np.arange(min, max, 1)

w0 = np.pi

for k in range(min, max):
    if (not k):
        continue
    f[k + max] = -np.arctan2(np.pi*k, 1)
    A[k + max] = (1-np.exp(-2))/np.sqrt(4+4*(np.pi*k)**2)
    x = x + A[k + max]*np.cos(k*w0 * t + f[k + max])
#
# fig = plt.figure()
# ax = fig.add_subplot(1, 1, 1)
# ax.plot(t, x)
# plt.show()

# w = np.pi/4
# w0 = w0/4
#
# for k in ka:
#     if (not k):
#         continue
#     A = ((pow(-j, k)*(j*2*k*w+1)) - 1)/(w*w*k*k)
#     x0 = x0 + A*np.exp(j*k*w*t)
#     x1 = x1 + A*np.exp(j*k*w*(t - 4))
#
# x = x0 - x1

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.plot(t, x)
plt.show()
