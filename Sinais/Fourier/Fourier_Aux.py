import matplotlib.pyplot as plt
import numpy as np

max = 100
j = complex(0, 1)


def Plot_et():
    w0 = np.pi
    # t vai de -T à T
    t = np.linspace(-2, 2, 10000)
    # Valor médio da função
    x = (1 - np.exp(-2))/2
    for k in range(0, max):
        if (not k):
            continue
        f = -np.arctan2(np.pi*k, 1)
        A = (1-np.exp(-2))/np.sqrt(4+4*(np.pi*k)**2)
        x = x + 2*A*np.cos(k*w0 * t + f)
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    ax.set_title("exp(-t) com período de 2s")
    ax.set_xlabel("t(s)")
    ax.set_ylabel("sinal")
    ax.plot(t, x)
    plt.show()


def Plot_Fase_et():
    w0 = np.pi
    ka = np.arange(-max, max, 1)
    # t vai de -T à T
    t = np.linspace(-2, 2, 10000)
    # Valor médio da função
    x = (1 - np.exp(-2))/2
    A = np.zeros(max*2) * complex(1, 0)
    f = np.zeros(max*2)

    for k in ka:
        if (not k):
            A[k + max] = (1 - np.exp(-2))/2
            continue
        f[k + max] = -np.arctan2(np.pi*k, 1)
        A[k + max] = (1-np.exp(-2))/np.sqrt(4+4*(np.pi*k)**2)
        x = x + A[k + max]*np.cos(k*w0 * t + f[k + max])
    fig = plt.figure()
    # Magnitude
    ax = fig.add_subplot(1, 2, 1)
    ax.set_title("Magnitude de exp(-t)")
    ax.set_xlabel("w")
    ax.set_ylabel("|X(w)|")
    ax.scatter(w0 * ka, A)
    # Fase
    ax = fig.add_subplot(1, 2, 2)
    ax.set_title("Fase de exp(-t)")
    ax.set_xlabel("w")
    ax.set_ylabel("arg(X(w))")
    ax.scatter(w0 * ka, f)
    plt.show()


def Plot_tr():
    x = 0.0
    w = np.pi/4
    t = np.linspace(-8, 8, 10000)

    for k in range(-max, max):
        if (not k):
            continue
        A = ((pow(-j, k)*(j*2*k*w+1)) - 1)/(w*w*k*k)
        x = x + A*(np.exp(j*k*w*t) - np.exp(j*k*w*(t - 4)))
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    ax.set_title("Sinal 1-5(a)")
    ax.set_xlabel("t(s)")
    ax.set_ylabel("sinal")
    ax.plot(t, x)
    plt.show()


def Plot_Fase_tr():
    w = np.pi/4
    A = np.zeros(max + max) * complex(1, 0)
    ka = np.arange(-max, max, 1)

    for k in ka:
        if (not k):
            A[k + max] = 0
            continue
        A[k + max] = ((pow(-j, k)*(j*2*k*w+1)) - 1)/(w*w*k*k)
    fig = plt.figure()
    # Magnitude
    ax = fig.add_subplot(1, 2, 1)
    ax.set_title("Magnitude")
    ax.set_xlabel("w")
    ax.set_ylabel("mag")
    ax.scatter(w*ka, abs(A))
    # Fase
    ax = fig.add_subplot(1, 2, 2)
    ax.set_title("Fase")
    ax.set_xlabel("w")
    ax.set_ylabel("fase")
    ax.scatter(w*ka, np.arctan2(A.imag, A.real))
    plt.show()


def Set_k():
    global max
    try:
        print("Entre com o número de iterações")
        max = int(input(">> "))
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
            print("Erro ao ler entrada")


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
