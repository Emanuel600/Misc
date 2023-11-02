# -*- coding: utf-8 -*-

"""

@file: Transfer_Function_Aux.py

@brief: funções auxiliares para o arquivo "Transfer.py"

"""

# Usada para os números complexos
import cmath
# Chamadas/variáveis de sistema
import sys
# Gera gráficos, processa a função de transferência e os arrays de números
import matplotlib.colors as colors
import matplotlib.pyplot as plt
import control as ct
import numpy as np
# Cores do gráfico 3D
from matplotlib import cm
"""
função: Menu

@brief:             Processa entrada do usuário no menu inicial

"""


def Menu():
    print(Menu_Str)
    choice = input(">> ")
    try:
        Menu_Options[choice]()
    except:
        if (choice == "exit"):
            global exit
            exit = True
            return
        print("opção inválida, por favor tente novamente")
    return


"""
função:             Get_Transfer_Funtion

@brief:             Recebe a função de transferência do usuário

@returns:           H_str   - User input, formatted for better processing
                    H       - Object representing a transfer function
                                from the control module
"""


def Get_Transfer_Function():
    print("Entre com a função de transferência:")
    H_str = input("H(s) = ")
    H_str = H_str.lower().replace("^", "**").replace(",", ".")
    try:
        H = eval(H_str)
        try:  # H depende de s
            num, bar, den, trail = str(H).replace("\n", "", 1).split('\n')
            print("\n       " + num)    # Numerador
            print("H(s) = " + bar)      # 'Barra' de divisão "-----"
            print("       " + den)      # Denominador
        except:  # H é constante/independente de s
            print("H(s) = " + str(H))
    except:
        print("Entrada inválida", file=sys.stderr)
        # Mantém formato da saída consistente (vetor de 2 elementos)
        return -1, -1
    return (H_str, H)


def Display_Help():
    print(Help_String)
    return


"""

função: Plot_Transfer_Function

@brief:             Cria uma visualização gráfica da função H

@parameters:        H - Função de Transferência em função de s

"""


def Plot_Zeroes_And_Poles(H):
    try:
        # H é função de transferência
        zeros = H.zero()
        poles = H.pole()
    except:
        # Funciona como um cast para type(H) = int ou float
        H = float(H) + s
        H = H - s
        # Recebe zeros e polos de H
        zeros = H.zero()
        poles = H.pole()
    # Plota  Zeros
    zpax.scatter(zeros.real, zeros.imag, label="Zeros")
    # Plota  Polos
    zpax.scatter(poles.real, poles.imag, marker='x', label="Polos")
    # Adiciona labels, legenda e título
    zpax.legend()
    zpax.set_xlabel("σ")
    zpax.set_ylabel("jω")
    zpax.set_title("Zero-Pole Diagram")
    return


"""

função:             Plot_Transfer_Function_At_sigma0

@brief:             Cria uma visualização gráfica da função H para real(H) = 0

@parameters:        H_exp - Função de Transferência em função de s (sympfy)

"""


def Plot_Transfer_Function_At_sigma0(H_str):
    # Eixo 'x'
    s = j * np.linspace(-10.0, 10.0, 1000)
    # Eixo 'y'
    Hs = abs(eval(H_str))
    if (np.size(Hs) == 1):
        Hs = Hs * np.ones(np.size(s))
    # Plota H(s) x jω
    s0ax.plot(s.imag, Hs, label="σ = 0")
    # Adiciona labels, legenda e título
    s0ax.legend()
    s0ax.set_xlabel("jω")
    s0ax.set_ylabel("H(s)")
    s0ax.set_title("H(s), σ = 0")
    return


"""

função: Plot_Transfer_Function_3D

@brief:             Gera um gráfico 3D de H(s)

@parameters:        H_str - Função de Transferência em função de s (string)

"""


def Plot_Transfer_Function_3D(H_str):
    # Eixo imaginário
    wj = np.linspace(-3, 3, 50)
    # Eixo real
    sg = np.linspace(-3, 3, 50)
    # Eixos do plano XY
    X, Y = np.meshgrid(sg, wj)
    # Eixo 'z'
    s = X + j * Y
    Hs = abs(eval(H_str.replace('x', 's')))
    if (np.size(Hs) == 1):
        Hs = Hs * np.ones(X.shape)
    # Remove over/underflow do gráfico nos polos
    Z = np.minimum(5, Hs)

    surf = p3dax.plot_surface(X, Y, Z, cmap=cm.inferno)
    p3dax.set_xlabel("σ")
    p3dax.set_ylabel("jω")
    p3dax.set_zlabel("H(s)")
    p3dax.set_zlim(-1, 5)
    fig.colorbar(surf, shrink=0.5, aspect=5)
    p3dax.set_title("Função de Transferência 3D")
    return


"""
função:             Plot_All

@brief:             Cria gráficos dos polos e zeros, de H(s) para σ = 0,
                        e o gráfico H(σ, jω)

@parameters:        H_str   - String contendo o input do usuário (préformatado)
                    H       - Objeto TransferFunction contendo a função de
                                transferência
"""


def Plot_All(H_str, H):
    Plot_Zeroes_And_Poles(H)
    Plot_Transfer_Function_At_sigma0(H_str)
    Plot_Transfer_Function_3D(H_str)
    return

# Funções de conveniência Call_x chamam a função x depois de obter a
#   função do usuário


def Call_Plot_Zeroes_And_Poles():
    try:
        H_str, H = Get_Transfer_Function()
        # Modifica figura para apenas um gráfico
        global zpax
        fig = plt.figure()
        zpax = fig.add_subplot(1, 1, 1)
        Plot_Zeroes_And_Poles(H)
        plt.show()
        del zpax
    except:
        print("Erro ao processar a função, retornando ao menu inicial", file=sys.stderr)
        plt.close()
    return


def Call_Plot_Transfer_Function_At_sigma0():
    H_str, H = Get_Transfer_Function()
    temp = H_str
    while (temp == -1):
        H_str, H = Get_Transfer_Function()
        temp = H_str
    try:
        # Modifica figura para apenas um gráfico
        global s0ax
        fig = plt.figure()
        s0ax = fig.add_subplot(1, 1, 1)
        Plot_Transfer_Function_At_sigma0(H_str)
        plt.show()
        del s0ax
    except:
        print("Erro ao processar a função, retornando ao menu inicial", file=sys.stderr)
        plt.close()
    return


def Call_Plot_Transfer_Function_3D():
    H_str, H = Get_Transfer_Function()
    temp = H_str
    while (temp == -1):
        H_str, H = Get_Transfer_Function()
        temp = H_str
    try:
        global fig, p3dax
        # Cria figura para o gráfico 3D
        fig = plt.figure()
        p3dax = fig.add_subplot(1, 1, 1, projection='3d')
        Plot_Transfer_Function_3D(H_str)
        plt.show()
        del fig, p3dax
    except:
        print("Erro ao processar a função, retornando ao menu inicial", file=sys.stderr)
        plt.close()
    return


def Call_Plot_All():
    H_str, H = Get_Transfer_Function()
    temp = H_str
    while (temp == -1):
        H_str, H = Get_Transfer_Function()
        temp = H_str
    try:
        global fig, zpax, s0ax, p3dax
        fig = plt.figure(layout="tight")
        zpax = fig.add_subplot(2, 2, 1)
        s0ax = fig.add_subplot(2, 2, 3)
        p3dax = fig.add_subplot(2, 2, 2, projection='3d')
        Plot_All(H_str, H)
        plt.show()
        del fig, zpax, s0ax, p3dax
    except:
        print("Erro ao processar a função, retornando ao menu inicial", file=sys.stderr)
        plt.close()
    return
# -- Constantes -- #


# Utils
# s = σ + jω
s = ct.TransferFunction.s
# j = i
j = complex(0, 1)

# Strings
Intro_Screen = \
    """
      __      ___                 _ _              _
      \ \    / (_)               | (_)            | |
       \ \  / / _ ___ _   _  __ _| |_ ______ _  __| | ___  _ __
        \ \/ / | / __| | | |/ _` | | |_  / _` |/ _` |/ _ \| '__|
         \  /  | \__ \ |_| | (_| | | |/ / (_| | (_| | (_) | |
          \/   |_|___/\__,_|\__,_|_|_/___\__,_|\__,_|\___/|_|
                                  _
                                 | |
                               __| | ___
                              / _` |/ _ \\
                             | (_| |  __/
                              \__,_|\___|
                   ______                /\/|
                  |  ____|              |/\/
                  | |__ _   _ _ __   ___ __ _  ___
                  |  __| | | | '_ \ / __/ _` |/ _ \\
                  | |  | |_| | | | | (_| (_| | (_) |
                  |_|   \__,_|_| |_|\___\__,_|\___/
                                   )_)
                                  _
                                 | |
                               __| | ___
                              / _` |/ _ \\
                             | (_| |  __/
                              \__,_|\___|
     _______                   __          //\            _
    |__   __|                 / _|        |/ \|          (_)
       | |_ __ __ _ _ __  ___| |_ ___ _ __ ___ _ __   ___ _  __ _
       | | '__/ _` | '_ \/ __|  _/ _ \ '__/ _ \ '_ \ / __| |/ _` |
       | | | | (_| | | | \__ \ ||  __/ | |  __/ | | | (__| | (_| |
       |_|_|  \__,_|_| |_|___/_| \___|_|  \___|_| |_|\___|_|\__,_|
    """

Help_String = \
    """
    Entrada de dados:
        Para entrar com uma função de transferência, simplesmente a digite de
    acordo com a regra PEMDAS, da mesma forma que faria para escrevê-la em uma
    linha de código.
    ============================================================================
                                                    s^2 + 3s - 4
                Ex: (s^2 + 3*s - 4)/((s+3)*(s-1)) = ------------
                                                     (s+3)(s-1)
    ============================================================================
        Ao entrar com a função, você pode representar exponenciais como a^b ou
    a**b e o programa não diferencia entre letras maiúsculas e minúsculas. Todas
    as multiplicações DEVEM ser feitas explicitamente (3*s ao invés de 3s), o
    programa também retorna uma visualização da função entrada para que ela possa
    ser verificada em casos de resultados estranhos/inesperados.

        Caso a função entrada seja inválida, um de dois avisos serão retornados:
    "Entrada Inválida" caso ocorra um erro no processamento imediato da string -
    provavelmente causado por uma variável indevida ou erro de digitação; ou
    "Falha no processamento do sistema" caso a string seja válida mas um ou mais
    dos processamentos desejados (visualização 3D, polos e zeros, σ = 0) falharem.
    O programa irá voltar ao menu no primeiro caso e pedir que a função seja
    entrada novamente no segundo.

        Para sair do programa, ou saia bruscamente (Ctrl+C, clicar no 'x', etc.)
    ou digite "exit" no console no menu de seleção.

    Considerações:
        O programa usa eval() para determinar o valor de H(s), isto apresenta
    um risco de segurança, como você é um usuário confiável isso não é um
    problema muito grande, mas por favor não entre comandos que possam deletar
    arquivos/diretórios e nunca execute este script em modo de administrador.

        Devido ao uso da função eval(), é possível entrar com quase toda função
    matemática dentro dos módulos importados, incluindo o uso de números
    complexos, mas o módulo usado para calcular/plotar os valores relevantes da
    função H(s) NÃO considera valores imaginários, realisando um cast para o
    tipo float e descartando a parte imaginária.

    Possíveis Erros de Codificação:
        Como o script está configurado para UTF-8, existem alguns conflitos com
    o ASCII-ANSI, como o caractere 'σ', que pode ser confundido pelo caraceter 'o',
    também é possível que o programa encontre um caractere que não consegue decifrar
    e o substitua por '�', dependendo das configurações do terminal/editor usado.
"""

Menu_Str = \
    """
    Entre 'h' para ajuda com o programa;
    Entre 'z' para visualizar zeros e polos;
    Entre 'r' para visualizar H(s) para σ = 0;
    Entre 'g' para visualizar H(s) em 3D;
    Entre 's' para visualizar todos em uma mesma figura;
    Entre "exit" para sair.
"""

# Pares de caharctere:função* para implementação do menu
Menu_Options = {
    'h': Display_Help,
    'z': Call_Plot_Zeroes_And_Poles,
    'r': Call_Plot_Transfer_Function_At_sigma0,
    'g': Call_Plot_Transfer_Function_3D,
    's': Call_Plot_All
}

# Se deve sair ou não
exit = False
