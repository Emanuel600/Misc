/* Relações básicas */
/*
 *Carga:
 * Vl = L(i')
 * i  = C(Vc')
 * Vr = i*R
 * Vf = Vr+Vl+Vc
 * i' = (Vf-Vr-Vc)/L
 * Vc'= i/C
 *Descarga:
 * Vl = L(i')
 * i  = C(Vc')
 * Vr = i*R
 * Vc = (Vr+Vl)
*/


function alpha= calc_alpha (R, L)
    alpha=R/(2*L)
endfunction
function omega= calc_omega(L, C)
    omega= 1/sqrt(L*C)
endfunction
function plot_RLC(R, L, C, Vf, T, step)
    alpha= calc_alpha(R, L)
    omega= calc_omega(L, C)
    disp("== alpha ==")
    disp(alpha)
    disp("== omega ==")
    disp(omega)
    /* Carga */
    /* Analisando circuito - corrente */
    i_ini(1) = 0        // Igual a zero => indutor resiste a mudança em t=0+
    i_deri(1)= Vf/L     // Tensão do indutor igual a tensão da fonte em t=0+
    /* Analisando circuito - tensão */
    v_ini(1) = 0
    v_deri(1)= 0   // dv/dt=(i/C)=0 em t=0+
    /* Descarga */
    /* Analisando circuito - corrente */
    i_ini(2) = 0    // Igual a zero devido ao capacitor => tensão no resistor igual a zero em t=0+
    i_deri(2)= Vf/L // Tensão do indutor igual a tensão do capacitor em t=0+
    /* Analisando circuito - tensão */
    v_ini(2) = Vf
    v_deri(2)= 0   // dv/dt=(i/C)=0 em t=0+
    
    t = 0:step:T/2
    
    if alpha > omega then // Superamortecido
        root = sqrt(alpha^2-omega^2)
        s1   = -alpha + root
        s2   = -alpha - root
        
        disp("== s1 ==")
        disp(s1)
        disp("== s2 ==")
        disp(s2)
        
        K = [1 1 ; s1 s2]    // Matriz de parâmetros (Válido para tensão e corrente)
        /* Corrente do Circuito */
        SI= [i_ini(2) ;i_deri(2)] // Matriz solução
        KI= K\SI                  // Constantes multiplicativas(parâmetros)
        
        disp("== K1 (Corrente) ==")
        disp(KI(1))
        disp("== K2 (Corrente) ==")
        disp(KI(2))
        
        i = KI(1)*exp(s1*t)+KI(2)*exp(s2*t)
        /* Tensão do Capacitor */
        VS= [v_ini(2) ; v_deri(2)] // Matriz solução
        KV= K\VS                   // Constantes multiplicativas(parâmetros)
        
        disp("== K1 (Tensão) ==")
        disp(KV(1))
        disp("== K2 (Tensão) ==")
        disp(KV(2))
        
        Vc = KV(1)*exp(s1*t)+KV(2)*exp(s2*t)
        Vr = i*R
        Vl = Vc-Vr
    end
    
    if alpha == omega then // Critacamente amortecido
        i=(Vf/L)*exp(-alpha*t)
    end
    
    if alpha < omega then // Subamortecido
        wd   = sqrt(omega^2-alpha^2)
        disp("== wd ==")
        disp(wd)
        /* Corrente do Circuito*/
        IK1 = i_ini(2)
        IK2 = (i_deri(2)+IK1*alpha)/wd
        disp("== K1 (Corrente) ==")
        disp(IK1)
        disp("== K2 (Corrente) ==")
        disp(IK2)
        
        i    = exp(-alpha*t).*( IK1*cos(wd*t) + IK2*sin(wd*t) )
        /* Tensão do Capacitor*/
        VK1 = v_ini(2)
        VK2 = (v_deri(2)+VK1*alpha)/wd
        disp("== K1 (Tensão) ==")
        disp(VK1)
        disp("== K2 (Tensão) ==")
        disp(VK2)
        
        Vc   = exp(-alpha*t).*( VK1*cos(wd*t) + VK2*sin(wd*t) )
        
        Vr   = i*R
        Vl   = Vc-Vr
    end
    plot(t, Vc )
endfunction

R= 2.25e3+330
C= 1e-9
L= 5.6e-3
T= 75e-6

resolution= 1e3
step= T/resolution
Vf= 4

plot_RLC()
