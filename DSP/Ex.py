"""
DSP Exercises

@author: Emanuel S Araldi
"""
# %% Imports / Setup
import DSP

import numpy as np
# %% 2.1.1
s = DSP.Signal(-5, 15)
s.impulse(-2, 3)
s.impulse(0, 2)
s.impulse(3, -1)
s.impulse(7, 5)
s.plot()
# %% 2.1.2
s = DSP.Signal(-10, 10, "Ex 2.1.2")
s.exp(0.5)
s1 = DSP.Signal(-10, 10, "Partial")
for n in range(-10, 11, 2):
    s1.impulse(n, 1)
s *= s1
s.plot()

# %% 2.1.3
sig = DSP.stepseq(0, -1, 20)
sig[0] *= 10
sig[0] += -5*DSP.stepseq(5, -1, 20)[0] - 10*DSP.stepseq(10, -1, 20)[0] \
    + 5*DSP.stepseq(15, -1, 20)[0]
DSP.plot(sig, "Ex 2.1.3")

# %% 2.1.4
sig = DSP.stepseq(-20, -25, 15)
sig[0] -= DSP.stepseq(10, -25, 15)[0]
DSP.plot(sig, "Degraus para Ex 2.1.4")
sig[0] = np.exp(0.1*sig[1]) * sig[0]
DSP.plot(sig, "Ex 2.1.4")
# %% 2.1.5
sig = DSP.cos(-200, 200, 0.49*np.pi)
# 'sig' becomes a tuple for some reason
sig = np.array(sig)
sig[0] *= 5
sig[0] += 5*DSP.cos(-200, 200, 0.51*np.pi)[0]
DSP.plot(sig, "cos")

# %% 2.1.6
s = DSP.Signal(-200, 200)
s1 = DSP.Signal(-200, 200)
s.sin(0.01*np.pi, 2)
s.plot()
s1.cos(0.5*np.pi)
s1.plot()
s *= s1
s.plot()

# %% 2.1.7
s = DSP.Signal(0, 100)
s.sin(0.1*np.pi, fi=np.pi/3)
s1 = DSP.Signal(0, 100)
s1.exp(-0.05)
s *= s1
s.plot()
# %% 2.1.8
s = DSP.Signal(0, 100)
s.sin(0.1*np.pi)
s1 = DSP.Signal(0, 100)
s1.exp(0.01)
s *= s1
s.plot()
# %% Add test
s = DSP.Signal(-150, 150, "Meu sigadd")
s.sin(1.5)
s1 = DSP.Signal(-200, 200)
s1.sin(1.4)
s += s1
s.plot()
# Testando com a do professor para comparar
s = DSP.sin(-150, 150, 1.5)
s1 = DSP.sin(-200, 200, 1.4)
s = DSP.sigadd(s[0], s[1], s1[0], s1[1])
DSP.plot(s, "sigadd do prof")