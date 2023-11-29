"""

@file: Transfer.py

@brief: Recebe uma função de transferência H(s) do usuário,
         e cria uma visualização gráfica da função

@details: Cria um diagrama com os polos e zeros da função,
            um gráfico 3D da função, e um gráfico 2D
            para s = 0.

"""
import Transfer_Function_Aux as TFA
import sys

print(TFA.Intro_Screen)

while (not TFA.exit):
    TFA.Menu()

# Indica que o programa foi devidamente finalizado
sys.exit(0)
