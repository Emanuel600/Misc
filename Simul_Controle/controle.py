"""
Definitions of classes and functions for Control Theory Simulation

Author: Emanuel S Araldi
"""

from matplotlib import rcParams
from matplotlib.figure import Figure
from matplotlib import patches
import matplotlib.pyplot as plt

import tbcontrol as tct
import control as ct
import numpy as np
import scipy as sp

#
# Copyright (c) 2011 Christopher Felton, adapted by Emanuel Staub Araldi
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# The following is derived from the slides presented by
# Alexander Kain for CS506/606 "Special Topics: Speech Signal Processing"
# CSLU / OHSU, Spring Term 2011.


def zplane(G, title="plano z do sistema", filename=None):
    """Plot the complex z-plane given a transfer function.
    """

    # get a figure/plot
    ax = plt.subplot(111)

    # create the unit circle
    uc = patches.Circle((0, 0), radius=1, fill=False,
                        color='black', ls='dashed')
    ax.add_patch(uc)

    # Get the poles and zeros
    p = G.poles()
    z = G.zeros()

    # Plot the zeros and set marker properties
    t1 = plt.plot(z.real, z.imag, 'go', ms=10)
    plt.setp(t1, markersize=10.0, markeredgewidth=1.0,
             markeredgecolor='k', markerfacecolor='g')

    # Plot the poles and set marker properties
    t2 = plt.plot(p.real, p.imag, 'rx', ms=10)
    plt.setp(t2, markersize=12.0, markeredgewidth=3.0,
             markeredgecolor='r', markerfacecolor='r')

    ax.spines['left'].set_position('center')
    ax.spines['bottom'].set_position('center')
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)

    # set the ticks
    r = 1.5
    plt.axis('scaled')
    plt.axis([-r, r, -r, r])
    ticks = [-1, -.5, .5, 1]
    plt.xticks(ticks)
    plt.yticks(ticks)

    plt.title(title)

    if filename is None:
        plt.show()
    else:
        plt.savefig(filename)

    return z, p

def plot_step(Gz, t, title="Resposta ao Degrau", xl="t (ms)", yl="Out"):
    t, y = ct.step_response(Gz, T=t)
    tms  = 1e3*t
    f, ax = plt.subplots()
    ax.stem(tms, y)
    ax.step(tms, y, where="post")
    ax.grid(True, 'both')
    ax.set_xlabel(xl)
    ax.set_ylabel(yl)
    ax.set_title(title)
    return ax, t, y

def print_kwargs(**kwargs):
    print(kwargs["title"])
