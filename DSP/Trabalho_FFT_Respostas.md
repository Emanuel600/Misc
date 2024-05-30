# 1

## a

Podemos calcular a resolução(ρ) da seguinte maneira:

$$
N = 100 \newline
F_s = 5k \space Hz \\~\\
ρ = \dfrac{F_s}{N} = \dfrac{50\cancel{00}}{1\cancel{00}} = 50 \space Hz\\~\\
$$

Ou seja: Cada espectro cobre 50 Hz.

## b

Há um espectro em 500 Hz correspondendo à $F_1$ e
um em 1050 Hz, correspondendo à $F_2$, este está
um pouco fora do local esperado devido à resolução da FFT

## c

Isto se deve ao número limitado de amostras,
quanto maior o número de amostras, melhor a
definição dos picos no gráfico resultante.

O efeito observado é modelado pelo uso da função
heaviside (u(t)) para "janelar" as senóides originais

## d

O esplhamento vêm da interferência do espectro de $F_1$, devido a sua proximidade

## e

Os picos agora são muito mais definidos, porém ainda é possível ver
o efeito do janelamento

## f

É extremamente difícil separar as duas frequências, mas é possível ver um
segundo "pico" logo ao lado de f=500 Hz, mas este é quase indistinguível
do efeito de janelamento que foi observado nos casos anteriores
