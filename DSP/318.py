# %% Convenience Cell
import DSP

import numpy as np
import scipy.signal as sp
import matplotlib.pyplot as plt


def plot(x, y, xl='n', yl='y[n]', title=""):
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    # Titles and labels
    ax.set_xlabel(xl)
    ax.set_ylabel(yl)
    ax.stem(x, y)
    plt.title(title)
    return


#
# y[n] = ∑(x[n-2m], m=0, m=3) - ∑((0.81^l)y[n-2l], l=1, l=3)
# y[n] + 0.81*(y[n-2] + 0.81y[n-4] + 0.81^2y[n-6]) =
# x[n] + x[n-2]       +     x[n-4] +       x[n-6]

#    n    n-1  n-2   n-3    n-4    n-5    n-6
a = [1.0, 0.0, 0.81, 0.0, 0.81**2, 0.0, 0.81**3]
b = [1.0, 0.0, 1.0,  0.0,    1.0,  0.0,   1.0]
#####################################################
#                  1 + s^-2 + s^4 + s^-6            #
# H(s) = ------------------------------------------ #
#        1 + 0.81s^-2 + (0.81^2)s^-4 + (0.81^3)s^-6 #
#####################################################
#                  s^6 + s^4 + s^2 + 1              #
# H(s) = --------------------------------------     #
#        s^6 + 0.81s^4 + (0.81^2)s^2 + (0.81^3)     #
#####################################################
# Caso especial - w=0: s = e^0 = 1
H0 = 4/(1 + 0.81 + (0.81**2) + (0.81**3))


def get_H(w):  # Retorna H(w)
    j = complex(0, 1)
    s = np.exp(-j*w)
    H = (s**6 + s**4 + s**2 + 1)
    H = H/(s**6 + 0.81*s**4 + (0.81**2)*s**2 + (0.81**3))
    return H


def get_y(x):  # Retorna resposta completa
    return sp.lfilter(b, a, x)


nf = 200
n = np.arange(0, nf+1)
# %% 3.18.1
#        10*(-1^n)
x = 5 + (10*np.cos(n*np.pi))
y = get_y(x)
plot(n, y, "Resposta Completa")
# Cálculo de regme permanente
wx = np.pi
H = get_H(wx)
# Resposta ao cosseno
yss = np.abs(H)*10*np.cos(n*np.pi + np.angle(H))
# Resposta 'CC' (w=0)
yss = yss + np.abs(H0)*5

plot(n, yss, "Resposta de Regime Permanente")
# %% 3.18.2
wx = 0.5*np.pi
fi = np.pi/2
x = 1+np.cos(wx*n + fi)
y = get_y(x)
plot(n, y, "Resposta Completa")
# Cálculo de regime permanente
H = get_H(wx)
# Resposta ao cosseno
fi = fi + np.angle(H)
yss = np.abs(H)*10*np.cos(n*wx + fi)
yss = yss + np.abs(H0)

plot(n, yss, "Resposta ao Regime Permanente")
# %% 3.18.3
wx1 = np.pi/4
wx2 = 3*np.pi/4
x = 2*np.sin(wx1*n) + 3*np.cos(wx2*n)
y = get_y(x)
plot(n, y, "Resposta Completa")
# Regime Permanente
H1 = get_H(wx1)
H2 = get_H(wx2)
yss = 2*np.abs(H1)*np.sin(wx1*n + np.angle(H1)) + \
    3*np.abs(H2)*np.sin(wx2*n + np.angle(H2))
plot(n, yss, "Regime permanente")
