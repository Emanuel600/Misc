/* Criando Funções de Entrada */
function p = pulse(t)
    if t >= 0 then
        p = 1
    else
        p = 0
    end
endfunction

function s = sawtooth(t)
    if t >= 0 then
        s = t
    else
        s = 0
    end
endfunction

function plot_func(func_str, x)
    iter = 1
    for t = x
        y(iter) = evstr(func_str)
        iter = iter+1
    end
    
    plot(x, y, 'r--')
endfunction

/* Transformação de Laplace */
/* Definindo e Calculando Variáveis */
function a0 = calc_a0(T, func_str)
    a0 = integrate(func_str, 't', 0, T) / T
endfunction

function [an, bn] = calc_n(T, func_str, n)
    an = 2*integrate("(" + func_str + ") * cos(n*w0*t)", 't', 0, T)
    bn = 2*integrate("(" + func_str + ") * sin(n*w0*t)", 't', 0, T)
endfunction

T    = 2
w0   = 2*%pi/T
res  = 1e6
step = T/res

x    = 0:step:2*T

func_str = 'sawtooth(t)'
plot_func()
/*
disp("\==Calculando Parâmetros==/")
disp("! Imutáveis !")
a0 = calc_a0()
printf("a0 = %f\n", a0)
n = 1
disp("! Parâmetros Mutáveis !")
//while n < 5
    [a, b] = calc_n(2, func_str, 1)
    printf("Para n= {%d}:\na = %f\nb = %f", n, a, b)
    n = n+1
//end
*/
plot(x, sin(w0*x))





