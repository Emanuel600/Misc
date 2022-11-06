/* Definindo Funções */
// Função "heaviside"
function y=u(t)
    if t >= 0 then // u(t-a) começa em 'a'
        y = 1
    else
        y = 0
    end
endfunction
// Onda "dente de serra"
function y = sawtooth(t)
    if t >= 0 then
        y = t
    else
        y = 0
    end
endfunction
// Valor médio da função
function a0 = determine_a0(func, T) // func: string ; T: float
    a0 = integrate(func, 't', 0, T)
    a0 = a0/T
endfunction
// Determina parâmetros a(n) e b(n)
function [an, bn] = determine_nvar(func, T)
    an = 2*integrate("(" + func + ") * cos(n*w0*t)", 't', 0, T)/T
    bn = 2*integrate("(" + func + ") * sin(n*w0*t)", 't', 0, T)/T
endfunction
// imprime uma função literal
function plot_func(funcstr, x)
    /* Plota uma função literal qualquer
    * funcstr: string da função a ser plotada, variável deve ser 't'. Ex: funcstr = 'cos(t)'
    * x: vetor que será utilizado para evaluação dos pontos (eixo 'x')
    */
    ins = 1
    for t=x
        y(ins) = evstr(funcstr)
        ins = ins + 1
    end
    plot(x, y, 'r')
endfunction
// Calcula e retorna parâmetros e a transformação completa da função entrada
function [F, a, b, cc] = Fourier_transform(func, T, x, escala, offset, err_tol, conv_tol, min_iter, max_iter)
    /* Argumentos de entrada:
    * func: string literal da função a ser estimada (ex: ‘cos(t)’)
    * T: Período da função a ser analisada
    * x: vetor representando o eixo ‘x’
    * escala: 
    * offset: 
    * err_tol: Tolerância de erro no programa (padrão = 1e-4(%))
    * conv_tol: Tolerância de convergência na série calculada (padrão = 1e-3(%))
    * min_iter: Número mínimo de iterações para checar se há convergência (padrão = 10)
    */
    
    select argn(2) // Valores padrão
    case 5 then
        err_tol = 1e-4
        conv_tol= 1e-3
        min_iter= 1e3
        max_iter= 50
    case 6 then
        conv_tol= 1e-3
        min_iter= 1e3
        max_iter= 50
    case 7 then
        min_iter= 1e3
        max_iter= 50
    case 8 then
        max_iter= 50
    end
    
    erro = 1 // Erro da iteração atual
    erpr = 1 // Erro da iteração anterior
    
    cc = escala*determine_a0(func, T)+offset
    F = cc
    printf("CC: {%g}\n", cc)
    n  = 0 // Iteração atual sendo calculada
    w0 = (2*%pi)/T // Frequência angular fundamental
    /* Calcula 'F' */
    while ((erro > err_tol*1e-2) & n < max_iter)
        n = n+1
        
        [a(n), b(n)] =  determine_nvar(func, T)
        a(n) = escala*a(n)
        b(n) = escala*b(n)
        printf("==================================\n")
        printf("Iteração {%d}: a(%d)=%g | b(%d)=%g\n", n, n, a(n), n, b(n))
        sencos = a(n)*cos(n*w0*x) + b(n)*sin(n*w0*x)
        F = F + sencos
        
        max_real = escala*2 + offset
        
        erro = abs( max_real - max(F) )/(max_real) // Analisa erro no pico da onda (forma mais sensata nesse contexto)
        
        dedn = abs(erpr - erro) // Variação do erro ao longo de uma iteração
        
        if ( (dedn < conv_tol*1e-2) & n > min_iter)
            printf("==================================\n")
            printf("Iteração {%d}:\n", n)
            printf("Função ""erro"" convergiu com erro = %g%%\n", erro*100)
            printf("de/dn = %g%%\n", dedn*100)
            printf("==================================\n")
            break
        end
        
        erpr = erro
        
        printf("Erro relativo da iteração {%d}: {%f}%%\n", n, 100*erro)
    end
endfunction
// Calcula correntes nos elementos passivos, sem elemento CC
function [i, il, ic] = correntes_CA(a, b, w0, L, C, t)
    /* Argumentos de entrada:
    * a: Cossenos da série de Fourier
    * b: Senos da série de Fourier
    * w0: Frequência angular fundamental
    * L: Indutância do indutor
    * C: Capacitância do capacitor
    * t: Instantes para analisar
    * => Retorna:
    * i: Corrente saindo da fonte
    * il: Corrente no indutor
    * ic: Corrente no capacitor
    */
    i = 0
    il= 0
    ic= 0
    for n = 1:max(size(a))
        /* Calcula Impedâncias */
        ZL = %i*n*w0*L + 4
        ZC = 1/(n*w0*C*%i)
        ZCL= ZL+ZC
        Zeq= 2 + (ZC*ZL/ZCL)
        /* Calcula Correntes (Forma Fasorial) */
        FV = complex(b(n), a(n))
        Fi = FV/Zeq
        Fil= Fi*ZC/ZCL
        Fic= Fi*ZL/ZCL
        /* Converte (Fasorial -> senoidal) */
        [mod, phi] = polar(Fi)
        [modl, phil] = polar(Fil)
        [modc, phic] = polar(Fic)
        i  = i  + mod*sin(n*w0*t + phi)
        il = il + modl*sin(n*w0*t + phil)
        ic = ic + modc*sin(n*w0*t + phic)
    end
endfunction
// Calcula tensão nos elementos passivos do circuito, sem elemento CC
function [Vc, Vr1, Vr2, Vl] = tensoes_CA(fonte, i, il, ic)
    /* Argumentos de entrada:
    * fonte: Tensão suprida pela fonte
    * i: Corrente saindo da fonte
    * il: Corrente no indutor
    * ic: Corrente no capacitor
    * => Retorna:
    * Vc: Tensão no capacitor
    * Vr1: Tensão em R1
    * Vr2: Tensão em R2
    * Vl : Tensão no indutor
    */
    Vr1 = 2*i
    Vr2 = 4*il
    Vc  = fonte - Vr1
    Vl  = fonte - Vr1 - Vr2
endfunction
/* Plotando Resultados */
clc ; clf // Limpa console e gráfico
// Definindo variáveis
T = 2 // período
w0= (2*%pi)/T // Frequência angular fundamental
func = 'sawtooth(t)*(u(t) - u(t-T)) + sawtooth(t-T)*(u(t-T))' // Dois ciclos da onda (para plotar a "verdadeira")
x = 0:1e-2:(2*T) // "eixo" x (plano cartesiano)
// Escalando e adicionando offset
escala = 7.5
offset = -5
[F, a, b, cc] = Fourier_transform(func, T, x, escala, offset)

/* Componentes CC (tensão e corrente) */
icc = cc/6
Vr1cc = 2*icc
Vr2cc = 4*icc
Vccc  = Vr2cc
/* Componentes CA */
L = 1
C = 0.1
// Correntes
[i, il, ic] = correntes_CA(a, b, w0, L, C, x)
i = i + icc
il= il+ icc
// Tensões
[Vc, Vr1, Vr2, Vl] = tensoes_CA(F, i, il, ic)
Vr1 = Vr1 + Vr1cc
Vr2 = Vr2 + Vr2cc 
Vc  = Vc  + Vccc
/* Plotando Resultados */
plot(x, Vl, 'r')
plot(x, il)



