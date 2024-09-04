# Trabalho FFT

## 1

### a

Podemos calcular a resolução(ρ) da seguinte maneira:

$$
N = 100 \newline
F_s = 5k \space Hz \\~\\
ρ = \dfrac{F_s}{N} = \dfrac{50\cancel{00}}{1\cancel{00}} = 50 \space Hz\\~\\
$$

Ou seja: Cada espectro cobre 50 Hz.

### b

Há um espectro em 500 Hz correspondendo à $F_1$ e
um em 1050 Hz, correspondendo à $F_2$, este está
um pouco fora do local esperado devido à resolução da FFT.

### c

Isto se deve ao número limitado de amostras,
quanto maior o número de amostras, melhor a
definição dos picos no gráfico resultante.

O efeito observado é modelado pelo uso da função
heaviside (u(t)) para "janelar" as senóides originais.

### d

O espalhamento vêm da interferência do espectro de $F_1$, devido a sua proximidade e a resolução de frequência, que causa a divisão de potência de $F_2$ entre os dois "baldes" mais próximos

### e

Os picos agora são muito mais definidos, porém ainda é possível ver
o efeito do janelamento.

### f

É extremamente difícil separar as duas frequências, mas é possível ver um
segundo "pico" logo ao lado de f=500 Hz, mas este é muito menor do que observado nos casos anteriores, provavelmente devido a se encontrar fora de uma das faixas de frequência que estão no gráfico, causando seu espalhamento entre as faixas visinhas, como explicado em (e).

## 2

Podemos ver que as janelas **Hamming** e **Gaussiana** produzem picos mais bem definidos, sendo que a Gaussiana precisa de um ajuste fino no desvio padrão (σ) da janela. A janela retangular produz um resultado pior que a transformada direta do sinal, mas não muito diferente e a janela Blackman produz um resultado idêntico ao original. As janelas Kaiser possuem um bom resultado para β=0 e começa a ter distorções extremas para βs maiores, onde ocorre um espelhamento de frequência nas frequências mais altas.

## 3

Como o N determina a resolução de frequência da transformada, para ter os picos bem definidos seria ideal um N 2 vezes maior do que a maior frequência observada, já que isso resulta em um espalhamento mínimo no espectro.

Analisando a FFT do sinal limpo com N $\approx 15000$ (que deve ter a mesma frequência de amostragem), observamos que o sinal vai até $\approx 5500 Hz$ que resulta em um N de 11000.

Também há um "platô" que dura até 2k5 Hz para a flauta e 3k5 Hz para o violino e possuem pico em ~500 Hz, para podermos observar todos estes pontos -mais uma margem de segurança de ~1k- precisamos de N $\approx 7000$ para a flauta e N $\approx 9000$ para o violino, caso a localização exata do pico não seja de grande importância.

Considerando o tamanho original de cada sinal, N = 11000 acaba sendo a melhor escolha para análise precisa do sinal, o que também pode ser demonstrado experimentalmente
