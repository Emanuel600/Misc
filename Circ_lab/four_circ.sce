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
function [F, a, b, cc] = Fourier_transform(func, T, x, err_tol, conv_tol, min_iter, max_iter)
    /* Argumentos de entrada:
    * func: string literal da função a ser estimada (ex: ‘cos(t)’)
    * T: Período da função a ser analisada
    * x: vetor representando o eixo ‘x’
    * err_tol: Tolerância de erro no programa (padrão = 1e-4(%))
    * conv_tol: Tolerância de convergência na série calculada (padrão = 1e-3(%))
    * min_iter: Número mínimo de iterações para checar se há convergência (padrão = 10)
    */
    
    select argn(2) // Valores padrão
    case 3 then
        err_tol = 1e-4
        conv_tol= 1e-3
        min_iter= 1e3
        max_iter= 50
    case 4 then
        conv_tol= 1e-3
        min_iter= 1e3
        max_iter= 50
    case 5 then
        min_iter= 1e3
        max_iter= 50
    case 6 then
        max_iter= 50
    end
    
    erro = 1 // Erro da iteração atual
    erpr = 1 // Erro da iteração anterior
    
    cc = determine_a0(func, T)
    F = cc
    n  = 0 // Iteração atual sendo calculada
    w0 = (2*%pi)/T // Frequência angular fundamental
    /* Calcula 'F' */
    while ((erro > err_tol*1e-2) & n < max_iter)
        n = n+1
        
        [a(n), b(n)] =  determine_nvar(func, T)
        a(n) = a(n)
        b(n) = b(n)
        printf("==================================\n")
        printf("Iteração {%d}: a(%d)=%g | b(%d)=%g\n", n, n, a(n), n, b(n))
        sencos = a(n)*cos(n*w0*x) + b(n)*sin(n*w0*x)
        F = F + sencos
        
        erro = abs( 2 - max(F) )/(2) // Analisa erro no pico da onda (forma mais sensata nesse contexto)
        
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
function [i, il, ic] = correntes_CA(S, a, b, w0, L, C, t)
    /* Argumentos de entrada:
    * S: Escala
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
    n = 0
    i = 0
    il= 0
    ic= 0
    
    for n = 1:max(size(a))
        /* Calcula Impedâncias */
        ZL = %i*n*w0*L
        ZC = -%i/(n*w0*C)
        ZCL= ZL+ZC
        Zeq= 2 + (ZL*ZC/ZCL)
        /* Calcula Correntes (Forma Fasorial) */
        FV = S*complex(b(n), a(n))
        Fi = FV/Zeq
        Fil= Fi*ZC/ZCL
        Fic= Fi*ZL/ZCL
        /* Converte (Fasorial -> senoidal) */
        i = i + abs(FV)*sin(n*w0*t + atan(a(n)/b(n)))
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
    Vc  = Vr2
    Vl  = 0
    //Vl  = fonte - Vr1 - Vr2
endfunction
/* Plotando Resultados */
clc // Limpa console
// Definindo variáveis
T = 2 // período
w0= (2*%pi)/T // Frequência angular fundamental
func = 'sawtooth(t)*(u(t) - u(t-T)) + sawtooth(t-T)*(u(t-T))' // Dois ciclos da onda (para plotar a "verdadeira")
x = 0:1e-2:(2*T) // "eixo" x (plano cartesiano)
// Escalando e adicionando offset
escala = 7.5
offset = -5
[F, a, b, cc] = Fourier_transform(func, T, x)
F = escala*F + offset

/* Componentes CC (tensão e corrente) */
icc = cc/6
Vr1cc = 2*icc
Vr2cc = 4*icc
Vccc  = Vr2cc
/* Componentes CA */
L = 1
C = 0.1
// Correntes
[i, il, ic] = correntes_CA(escala, a, b, w0, L, C, x)
i = i + offset
il= il+ icc
// Tensões
[Vc, Vr1, Vr2, Vl] = tensoes_CA(F*escala, i, il, ic)
Vr1 = Vr1 + Vr1cc
/* Plotando Resultados */
plot(x, -i, 'r--')
plot(x, F)
//plot(x, Vr1)



