# %% Convenience Cell
import DSP

import numpy as np
import matplotlib.pyplot as plt


def plot(x, y, xl='n', yl='y[n]', title=""):
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    # Titles and labels
    ax.set_xlabel(xl)
    ax.set_ylabel(yl)
    ax.plot(x, y)
    plt.title(title)
    return


def get_y(X):
    y = np.zeros([X.size])
    for i in range(X.size):
        for m in range(0, 3+1):
            try:
                y[i] += X[i - 2*m]
            except:
                y[i] += 0
        for l in range(1, 2+1):
            try:
                y[i] -= y[i-2*l]*(0.81)**l
            except:
                y[i] -= 0
        i += 1
    return y


nf = 200
n = np.arange(0, nf+1)
print(n[-1])
# %% 3.18.1
x = 5 + (10*np.cos(n * (np.pi)))
y = get_y(x)
plot(n, x)
# %%
