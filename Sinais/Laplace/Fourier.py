import cmath
import matplotlib.pyplot as plt
import numpy as np

max = 1000
min = -max

j = complex(0, 1)
t = np.linspace(-16, 16, max)
ka = np.arange(min, max, 1)
x = 0.0
x0 = 0.0
x1 = 0.0
x2 = 0.0
x3 = 0.0
A = np.zeros(max - min)
f = np.zeros(max - min)
A0 = np.zeros(max - min)
f0 = np.zeros(max - min)
A1 = np.zeros(max - min)
f1 = np.zeros(max - min)
w = np.pi * np.arange(min, max, 1)

w0 = np.pi

# for k in range(min, max):
#     if (not k):
#         continue
#     f[k + max] = -np.arctan2(np.pi*k, 1)
#     A[k + max] = (1-np.exp(-2))/np.sqrt(4+4*(np.pi*k)**2)
#     x = x + A[k + max]*np.cos(k*w0 * t + f[k + max])
#
# fig = plt.figure()
# ax = fig.add_subplot(1, 1, 1)
# ax.plot(t, x)
# plt.show()

w = w/4
w0 = w0/4

for k in ka:
    if (not k):
        continue
    # Dente de Serra
    A0[k + max] = 1/k  # Dividir por np.pi depois
    x0 = x0 - A0[k + max]*np.sin(k*w0 * t)
    x2 = x2 - A0[k + max]*np.sin(k*w0 * (t+4))
    # Triangular
    if (not (k % 2) or (k < 1)):
        A1[k + max] = 0
        continue
    # multiplicar por 8 e dividir por pi^2 depois
    A1[k + max] = pow(-1, (k-1)/2)/(k*k)
    x1 = x1 + A1[k + max]*np.sin(k*w0/2 * (t - 4))
    x3 = x3 + A1[k + max]*np.sin(k*w0/2 * t)

x0 = x0/(np.pi*2)
x2 = x2/(np.pi*2)
x1 = 8*x1/(np.pi*np.pi)
x3 = 8*x3/(np.pi*np.pi)
x = (x0 - (x1/2)) + x1

fig = plt.figure()
ax = fig.add_subplot(1, 2, 1)
ax.plot(t, x)
ax = fig.add_subplot(1, 2, 2)
ax.plot(t, (x0 - (x1/2)))
ax.plot(t, x1)
plt.show()
