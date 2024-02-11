import matplotlib.pyplot as plt
import numpy as np
import signal

k_lim = 100
j = complex(0, 1)


# Plota o sinal 6.1-3
def Plot_et():
    T0 = np.pi/2
    w0 = 2*np.pi/T0
    t = np.linspace(-T0, T0, 10000)
    # Valor médio da função
    x = (1 - np.exp(-T0))/T0
    for k in range(0, k_lim):
        if (not k):
            continue
        # T0 é cancelado
        f = -np.arctan2(w0*k, 1)
        A = (1-np.exp(-T0))/(T0*np.sqrt(T0**2+(w0*k)**2))
        x = x + 2*A*np.cos(k*w0 * t + f)
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    # Sinal Recriado
    ax.set_title("exp(-t) com período de " + str(T0))
    ax.set_xlabel("t(s)")
    ax.set_ylabel("sinal")
    ax.plot(t, x)
    # Linha de valor mínimo da função original
    ax.plot(t, np.exp(-T0)*np.ones(t.size), '--')
    # Linha de valor máximo da função original
    ax.plot(t, (1)*np.ones(t.size), '--')
    # Sinal real
    t = np.linspace(-T0, T0, 50)
    # Deslocado T0 à direita
    x = np.exp(-(t-T0))*(np.heaviside((t-T0), 1) -
                         np.heaviside(t - 2*T0, 1))
    # Centrado
    x = x + np.exp(-t)*(np.heaviside(t, 1) -
                        np.heaviside(t - T0, 1))
    # Deslocado T0 à esquerda
    x = x + np.exp(-(t+T0))*(np.heaviside((t+T0), 1) -
                             np.heaviside(t, 1))
    ax.plot(t, x, 'ro')
    plt.show()


# Plota o espectro do sinal 6.1-3
def Plot_Fase_et():
    w0 = np.pi
    w = w0 * np.arange(-k_lim, k_lim + 1, 1)
    ka = np.arange(0, k_lim + 1, 1)
    # Valor médio da função
    x = (1 - np.exp(-2))/2
    A = np.zeros(k_lim*2 + 1) * complex(1, 0)
    f = np.zeros(k_lim*2 + 1)

    for k in ka:
        if (not k):
            A[k + k_lim] = x
            continue
        f[k_lim - k] = np.arctan2(w0*k, 1)
        A[k_lim - k] = (1-np.exp(-2))/np.sqrt(4+4*(w0*k)**2)
        f[k + k_lim] = -f[k_lim - k]
        A[k + k_lim] = A[k_lim - k]
    fig = plt.figure()
    # Magnitude
    ax = fig.add_subplot(1, 2, 1)
    ax.set_title("Magnitude de exp(-t)")
    ax.set_xlabel("w")
    ax.set_ylabel("|X(w)|")
    ax.scatter(w, A)
    # Fase
    ax = fig.add_subplot(1, 2, 2)
    ax.set_title("Fase de exp(-t)")
    ax.set_xlabel("w")
    ax.set_ylabel("arg(X(w))")
    ax.scatter(w, f)
    plt.show()


# Plota o sinal 6.1-5
def Plot_tr():
    x = 0.0
    T0 = 8.0
    w = 2*np.pi/T0
    t = np.linspace(-T0, T0, 10000)

    for k in range(0, k_lim):
        if (not k):
            continue
        # k > 0
        A = ((pow(-j, k)*(j*(T0/4)*k*w+1)) - 1)/(w*w*k*k)
        x = x + A*(np.exp(j*k*w*t)*(1 - np.exp(j*k*w*T0/2)))
        # k < 0
        A = ((pow(-j, -k)*(-j*(T0/4)*k*w+1)) - 1)/(w*w*k*k)
        x = x + A*np.exp(-j*k*w*t)*(1 - np.exp(j*k*w*T0/2))
    x = x/16
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    # Sinal Recriado
    ax.set_title("Sinal 1-5(a)")
    ax.set_xlabel("t(s)")
    ax.set_ylabel("sinal")
    ax.plot(t, x)
    # Linha de valor mínimo da função original
    ax.plot(t, (-1)*np.ones(t.size), '--')
    # Linha de valor máximo da função original
    ax.plot(t, (1)*np.ones(t.size), '--')
    # Sinal Real
    t = np.linspace(-T0, T0, 50)
    x = ((t-T0)/2)*(np.heaviside((t-T0), 1) - np.heaviside((t-T0)-T0/4, 1))
    x = x - ((t-(T0/2))/2)*(np.heaviside((t-(T0/2)), 1) -
                            np.heaviside((t-(T0/2))-T0/4, 1))
    x = x + (t/2)*(np.heaviside(t, 1) - np.heaviside(t-T0/4, 1))
    x = x - ((t+(T0/2))/2)*(np.heaviside((t+(T0/2)), 1) -
                            np.heaviside((t+(T0/2))-T0/4, 1))
    x = x + ((t+T0)/2)*(np.heaviside((t+T0), 1) - np.heaviside((t+T0)-T0/4, 1))
    ax.plot(t, x, 'ro')
    plt.show()


# Plota o espectro do sinal 6.1-5
def Plot_Fase_tr():
    w0 = np.pi/4
    w = w0 * np.arange(-k_lim, k_lim + 1, 1)
    A = np.zeros(2*k_lim + 1) * complex(1, 0)
    ka = np.arange(0, k_lim + 1, 1)

    for k in ka:
        if (not k):
            A[k_lim] = 0
            continue
        # k < 0
        A[k_lim - k] = ((pow(-j, -k)*(j*2*-k*w0+1)) - 1) / \
            (w0*w0*k*k)
        # k > 0
        A[k + k_lim] = ((pow(-j, k)*(j*2*k*w0+1)) - 1) / \
            (w0*w0*k*k)
    fig = plt.figure()
    # Magnitude
    ax = fig.add_subplot(1, 2, 1)
    ax.set_title("Magnitude")
    ax.set_xlabel("w")
    ax.set_ylabel("mag")
    ax.scatter(w, abs(A))
    # Fase
    ax = fig.add_subplot(1, 2, 2)
    ax.set_title("Fase")
    ax.set_xlabel("w")
    ax.set_ylabel("fase")
    ax.scatter(w, np.arctan2(A.imag, A.real))
    plt.show()


def Set_k():
    global k_lim
    try:
        print("Entre com o número de iterações")
        k_lim = int(input(">> "))
    except:
        print("Valor inválido")


def Menu():
    global stay
    print(Menu_Str)
    choice = input(">> ")
    try:
        Menu_Dic[choice]()
    except:
        if (choice == "exit"):
            stay = 0
        else:
            print("Erro ao ler a entrada")


# Variáveis Auxiliares
Menu_Dic = {
    "et": Plot_et,
    "tr": Plot_tr,
    "fet": Plot_Fase_et,
    "ftr": Plot_Fase_tr,
    "k": Set_k
}

Menu_Str = \
    """
    Escolha uma das opções:

    et      - Gráfico do sinal 6.1-3
    tr      - Gráfico do sinal 6.1-5
    fet     - Espectro do sinal 6.1-3
    ftr     - Espectro do sinal 6.1-5
    k       - Definir número de iterações na série de Fourier
    exit    - Sair do programa
"""

Intro_Str = \
    """
          _____     __          _
         / ____|   /_/         (_)
        | (___     ___   _ __   _    ___
         \___ \   / _ \ | '__| | |  / _ \\
         ____) | |  __/ | |    | | |  __/
        |_____/   \___| |_|    |_|  \___|
                      _
                     | |
                   __| |   ___
                  / _` |  / _ \\
  ______         | (_| | |  __/   _
 |  ____|         \__,_|  \___|  (_)
 | |__      ___    _   _   _ __   _    ___   _ __
 |  __|    / _ \  | | | | | '__| | |  / _ \ | '__|
 | |      | (_) | | |_| | | |    | | |  __/ | |
 |_|       \___/   \__,_| |_|    |_|  \___| |_|
"""

stay = 1
