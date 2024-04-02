"""
Definitions of classes and functions for Digital Signal Processing

Author: Emanuel S Araldi
"""

import matplotlib.pyplot as plt
import numpy as np
import scipy as sp

"""
@brief: Takes two signals with different 'n' vectors, and equalizes 'n'

@param: sig1        - First signal
@param: sig2        - Second signal
@ret:   sig1, sig2  - Resulting signals, with the same 'n' vector
"""


def equal_n(sig1, sig2):
    try:  # Signal is a numpy array of (n, x) form
        n1 = sig1[1]
        x1 = sig1[0].copy()
        n2 = sig2[1]
        x2 = sig2[0].copy()
    except:  # Part of class "Signal"
        n1 = sig1.n
        x1 = sig1.val.copy()
        n2 = sig2.n
        x2 = sig2.val.copy()
    # Normalizes
    nmin = min(n1[0], n2[0])        # => n1 and n2 are ascending
    nmax = max(n1[-1], n2[-1])+1
    n = np.arange(nmin, nmax, 1)

    y1 = np.zeros(len(n))
    y2 = y1.copy()

    # Adapted from professor's sigadd
    y1[np.nonzero(np.logical_and((n >= n1[0]),
                                 (n <= n1[-1])) == 1)] = x1
    y2[np.nonzero(np.logical_and((n >= n2[0]),
                                 (n <= n2[-1])) == 1)] = x2

    return [y1, y2], n


def Four_Plot_Same(F, title="Transformada de Fourier",
                   y1='|H(w)|', y2='Phase'):
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    # Titles and labels
    ax.set_title(title)
    ax.set_xlabel('w')
    ax.set_ylabel(y1)
    ax2 = ax.twinx()  # instantiate a second axes that shares the same x-axis
    # we already handled the x-label with ax
    ax2.set_ylabel(y2)
    ax2.tick_params(axis='y')
    fig.tight_layout()  # otherwise the right y-label is slightly clipped
    # Plot
    ax.plot(F[1], np.abs(F[0]))
    ax2.stem(F[1], np.angle(F[0]), 'r--')
    # Add legend
    ax.legend("Magnitude")
    ax2.legend("Phase")
    return


def Four_Plot_Sep_Sub(F, title="Transformada de Fourier",
                      y1='|H(w)|', y2='Phase'):
    fig = plt.figure()
    ax1 = fig.add_subplot(2, 1, 1)
    ax2 = fig.add_subplot(2, 1, 2)
    # Titles and labels
    plt.title(title)
    ax1.set_xlabel('w')
    ax1.set_ylabel(y1)
    ax2.set_xlabel('w')
    ax2.set_ylabel(y2)
    fig.tight_layout()  # otherwise the right y-label is slightly clipped
    # Plot
    ax1.plot(F[1], np.abs(F[0]))
    ax2.stem(F[1], np.angle(F[0]), 'r--')
    # Add legend
    ax1.legend("Magnitude")
    ax2.legend("Phase")
    return


def Four_Plot_Sep(F, title="Transformada de Fourier",
                  y1='|H(w)|', y2='Phase'):
    fig = plt.figure()
    # First plot
    Four_Plot_Mag(F, title, y1)
    # Second plot
    fig.tight_layout()
    fig = plt.figure()
    ax2 = fig.add_subplot(1, 1, 1)
    # Titles and labels
    plt.title(title)

    ax2.set_xlabel('w')
    ax2.set_ylabel(y2)
    # Plot
    ax2.stem(F[1], np.angle(F[0]), 'r--')
    # Add legend
    ax2.legend("Phase")
    return


def Four_Plot_Mag(F, title="Transformada de Fourier",
                  y1='|H(w)|', y2=None):
    fig = plt.figure()
    # First plot
    fig.tight_layout()
    ax1 = fig.add_subplot(1, 1, 1)
    # Titles and labels
    ax1.set_xlabel('w')
    ax1.set_ylabel(y1)
    ax1.plot(F[1], np.abs(F[0]))
    ax1.legend("Magnitude")
    plt.title(title)
    return


"""
@brief: Defines a signal (x[n]) and the operations to be performed on it

@var: n - numpy array containing the number of the samples
@var: val - numpy array containg the values mapped to the 'n' vector
@var: title - title used for plotting
"""


class Signal:
    # Basic Methods
    def __init__(self, lower_bound, upper_bound, title=None):
        self.n = np.arange(lower_bound, upper_bound + 1, 1)
        self.val = np.zeros(self.n.shape)
        if (title != None):
            self.title = title
        else:
            self.title = "Signal"

    def __mul__(self, s):
        [y1, y2], n = equal_n(self, s)
        ret = Signal(n[0], n[-1])
        ret.set_sig(np.multiply(y1, y2))
        return ret

    def __imul__(self, s):
        [y1, y2], n = equal_n(self, s)

        self.val = np.multiply(y1, y2)
        self.n = n
        return self

    def __add__(self, s):
        [y1, y2], n = equal_n(self, s)
        ret = Signal(n[0], n[-1])
        ret.set_sig(y1 + y2)
        return ret

    def __iadd__(self, s):
        [y1, y2], n = equal_n(self, s)

        self.val = y1 + y2
        self.n = n

        return self

    def __sub__(self, s):
        [y1, y2], n = equal_n(self, s)
        ret = Signal(n[0], n[-1])
        ret.set_sig(y1 - y2)
        return ret

    def __isub__(self, s):
        [y1, y2], n = equal_n(self, s)

        self.val = y1 - y2
        self.n = n
        return self

    def __irshift__(self, num):
        self.n += num
        return self

    def __ilshift__(self, num):
        self.n -= num
        return self

    def __rshift__(self, num):
        r = self.n + num
        return r

    def __lshift__(self, num):
        r = self.n - num
        print(r)
        return r

    # Modified Convolution, from professor's DSP
    def __xor__(self, s):
        nyb = self.n[0]+s.n[0]
        nye = self.n[len(self.val)-1] + s.n[len(s.val)-1]
        ny = np.arange(nyb, nye+1)
        y = np.convolve(self.val, s.val)
        return [y, ny]

    def __ixor__(self, s):
        nyb = self.n[0]+s.n[0]
        nye = self.n[len(self.val)-1] + s.n[len(s.val)-1]
        self.n = np.arange(nyb, nye+1)
        self.val = np.convolve(self.val, s.val)

    # Class Methods
    # Impulse signal
    def impulse(self, n, A=1):
        temp = np.where(self.n == n)
        if (not temp[0].size):
            print("Invalid 'n'")
            return
        self.val[temp] += A
        return

    # Exponential Signal
    def exp(self, k, A=1, off=0):
        self.val = A*np.exp(k*(self.n - off))
        return

    # Sine Signal
    def sin(self, w, A=1, fi=0):
        fi = fi*np.pi/180  # Degree -> rad
        self.val = A*np.sin(w*self.n + fi)
        return

    # Cosine Signal
    def cos(self, w, A=1, fi=0):
        fi = fi*np.pi/180  # Degree -> rad
        self.val = A*np.cos(w*self.n + fi)
        return

    def heaviside(self, n0=0, A=1):
        self.val = A*np.heaviside(self.n - n0, 1)
        return

    def moving_avg(self, samples=2):
        final_size = len(self.n)-samples+1
        s = Signal(self.n[0], final_size + self.n[0] - 1)
        i = 0
        while i < final_size:
            window = self.val[i: i+samples]
            s.val[i] = np.sum(window)/samples
            i += 1
        return s

    def filter(self, wc, order=2, type="lowpass"):
        filtered = Signal(self.n[0], self.n[-1])
        sos = sp.signal.butter(N=order, Wn=wc/(np.pi),
                               btype=type, output='sos')
        filtered.val = sp.signal.sosfilt(sos, self.val)

        return filtered

    def add_noise(self, var=1, mean=0):
        self.val += np.random.normal(mean, var/100, self.val.shape)
        return

    def fourier(self, points=500, half=False):
        i = 0
        j = complex(0, 1)
        if (not half):
            W = np.linspace(0, 2*np.pi, points)
        else:
            W = np.linspace(0, np.pi, points)
        F = np.zeros(len(W)) * j
        for w in W:
            F[i] = np.sum(self.val*np.exp(-j*w*self.n))
            i += 1
        if (half):
            F = 2*F

        return [F, W, self.n]

    def get_sig(self):
        return self.val

    def set_sig(self, new_val):
        try:
            self.val = new_val
        except:
            print("Error setting signal")

    # Plot Signal
    def plot(self, xl='n', yl='y[n]', title=None):
        fig = plt.figure()
        ax = fig.add_subplot(1, 1, 1)
        # Titles and labels
        if (title == None):
            ax.set_title(self.title)
        else:
            ax.set_title(title)
        ax.set_xlabel(xl)
        ax.set_ylabel(yl)
        # Plot
        plt.stem(self.n, self.val)
        return

# Plot de Conveniência


def plot(signal, title="Signal", xl='n', yl='y[n]'):
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    # Titles and labels
    ax.set_title(title)
    ax.set_xlabel(xl)
    ax.set_ylabel(yl)
    # Plot
    plt.stem(signal[1], signal[0])

# Plot de conveniência para transformada de Fourier


def Plot_Fourier(F, type="Mag_Only",
                 title="Transformada de Fourier",
                 y1='|H(w)|', y2='Phase'):

    Four_Plot_Funcs[type](F, title, y1, y2)
    return


"""
@brief: Inverse Fourier Transform

@var:   F - np array on form (X[w], w, n)
@ret:   s - Signal reconstructed from F

@obs:   The params n0 and nf are fail-safes
"""


def inv_four(F, n0=-10, nf=10):
    i = 0
    j = complex(0, 1)
    X = F[0]  # => X(w)
    try:
        N = F[2]
    except:
        N = np.arange(n0, nf+1)
    s = Signal(0, 0)
    s.n = N
    x = np.zeros(len(N))

    for n in N:
        x[i] += np.trapz(X*np.exp(j*F[1]*n), F[1])
        i += 1

    s.val = x/(2*np.pi)

    return s


def cos(start, end, w=1):
    n = np.arange(start, end+1, 1)
    return np.cos(w*n), n


def sin(start, end, w=1):
    n = np.arange(start, end+1, 1)
    return np.sin(w*n), n


# fDSP do professor
def impseq(n0, n1, n2):

    #      Generates x(n) = delta(n-n0); n1 <= n <= n2
    #      ----------------------------------------------
    #      [x,n] = impseq(n0,n1,n2)
    #

    n = np.array(range(n1, n2+1))
    # Shift by n0
    x = n-n0
    for i in range(len(x)):
        # Only x[n0] == 0
        if x[i] != 0:
            x[i] = 0
        else:
            x[i] = 1
    # x = (n-n0) == 0
    return [x, n]


def stepseq(n0, n1, n2):
    #     Generates x(n) = u(n-n0); n1 <= n <= n2
    #     ------------------------------------------
    #     [x,n] = stepseq(n0,n1,n2)
    #
    n = np.arange(n1, n2+1)
    x = n-n0
    for i in range(len(x)):
        if x[i] < 0:
            x[i] = 0
        else:
            x[i] = 1
    # x = [(n-n0) >= 0]
    return [x, n]


def sigadd(x1, n1, x2, n2):
    # % implements y(n) = x1(n)+x2(n)
    # % -----------------------------
    # % [y,n] = sigadd(x1,n1,x2,n2)
    # % y = sum sequence over n, which includes n1 and n2
    # % x1 = first sequence over n1
    # % x2 = second sequence over n2 (n2 can be different from n1)
    # %
    n = np.arange(min(n1.min(0), n2.min(0)), max(
        n1.max(0), n2.max(0))+1)  # duration of y(n)
    y1 = np.zeros((1, len(n)))  # initialization
    y1 = y1[0, :]
    y2 = y1.copy()
    y1[np.nonzero(np.logical_and((n >= n1.min(0)),
                  (n <= n1.max(0))) == 1)] = x1.copy()
    y2[np.nonzero(np.logical_and((n >= n2.min(0)),
                  (n <= n2.max(0))) == 1)] = x2.copy()
    y = y1+y2
    return [y, n]


def sigmult(x1, n1, x2, n2):
    # % implements y(n) = x1(n)*x2(n)
    # % -----------------------------
    # % [y,n] = sigmult(x1,n1,x2,n2)
    # % y = product sequence over n, which includes n1 and n2
    # % x1 = first sequence over n1
    # %
    n = np.arange(min(n1.min(0), n2.min(0)), max(
        n1.max(0), n2.max(0))+1)  # duration of y(n)
    y1 = np.zeros((1, len(n)))  # initialization
    y1 = y1[0, :]
    y2 = y1.copy()
    y1[np.nonzero(np.logical_and((n >= n1.min(0)),
                  (n <= n1.max(0))) == 1)] = x1.copy()
    y2[np.nonzero(np.logical_and((n >= n2.min(0)),
                  (n <= n2.max(0))) == 1)] = x2.copy()
    y = y1*y2
    return [y, n]


def sigshift(x, m, k):
    # % implements y(n) = x(n-k)
    # % -------------------------
    # % [y,n] = sigshift(x,m,k)
    # %
    n = m+k
    y = x.copy()
    return [y, n]


def sigfold(x, n):
    # % implements y(n) = x(-n)
    # % -----------------------
    # % [y,n] = sigfold(x,n)
    # %
    y = np.flip(x)
    n = -np.flip(n)
    return [y, n]


def conv_m(x, nx, h, nh):
    # Modified convolution routine for signal processing
    # --------------------------------------------------
    # [y,ny] = conv_m(x,nx,h,nh)
    # [y,ny] = convolution result
    # [x,nx] = first signal
    # [h,nh] = second signal
    #
    nyb = nx[0]+nh[0]
    nye = nx[len(x)-1] + nh[len(h)-1]
    ny = np.arange(nyb, nye+1)
    y = np.convolve(x, h)
    return [y, ny]

# Adicionais por mim


# Function Dictionary For Fourier Plotting
Four_Plot_Funcs = {
    "Same": Four_Plot_Same,
    "Separate_Sub": Four_Plot_Sep_Sub,
    "Separate": Four_Plot_Sep,
    "Mag_Only": Four_Plot_Mag
}
