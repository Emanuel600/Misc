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
function plot_RLC(R, L, C, Vf, T, resolution)
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
    
    if alpha > omega then // Superamortecido
        root = sqrt(alpha^2-omega^2)
        s1   = -alpha + root
        s2   = -alpha - root
        
        disp("== s1 ==")
        disp(s1)
        disp("== s2 ==")
        disp(s2)
        
        /* Determinar Periodo */
        if s1>s2 then
            T = abs(6/s1)
        else
            T = abs(6/s2)
        end
        
        disp("Período: ", T)
        
        step = T/resolution
        
        t = 0:step:T
        
        K = [1 1 ; s1 s2]    // Matriz de parâmetros (Válido para tensão e corrente)
        /* Carga */
        disp("\== Carga ==/")
        /* Corrente do Circuito */
        SI= [i_ini(1) ; i_deri(1)] // Corrente em regime permanente é zero
        KI= K\SI
        
        disp("== K1 (Corrente) ==")
        disp(KI(1))
        disp("== K2 (Corrente) ==")
        disp(KI(2))
        
        i_carga = KI(1)*exp(s1*t)+KI(2)*exp(s2*t)
        /* Tensão do Capacitor */
        VS= [v_ini(1)+Vf ; v_deri(1)]
        KV= K\VS
        
        disp("== K1 (Tensão) ==")
        disp(KV(1))
        disp("== K2 (Tensão) ==")
        disp(KV(2))
        
        Vc_carga = Vf - (KV(1)*exp(s1*t)+KV(2)*exp(s2*t))
        Vr_carga = i_carga*R
        Vl_carga = Vc_carga-Vr_carga+Vf
        
        /* Descarga */
        disp("\== Descarga ==/")
        /* Corrente do Circuito */
        SI= [i_ini(2) ; i_deri(2)] // Matriz solução
        KI= K\SI                  // Constantes multiplicativas(parâmetros)
        
        disp("== K1 (Corrente) ==")
        disp(KI(1))
        disp("== K2 (Corrente) ==")
        disp(KI(2))
        
        i_descarga = KI(1)*exp(s1*t)+KI(2)*exp(s2*t)
        /* Tensão do Capacitor */
        VS= [v_ini(2) ; v_deri(2)] // Matriz solução
        KV= K\VS                   // Constantes multiplicativas(parâmetros)
        
        disp("== K1 (Tensão) ==")
        disp(KV(1))
        disp("== K2 (Tensão) ==")
        disp(KV(2))
        
        Vc_descarga = KV(1)*exp(s1*t)+KV(2)*exp(s2*t)
        Vr_descarga = i_descarga*R
        Vl_descarga = Vc_descarga-Vr_descarga
    end
    
    if alpha == omega then // Critacamente amortecido
        i=(Vf/L)*exp(-alpha*t)
    end
    
    if alpha < omega then // Subamortecido
        T = abs(6/alpha)
        step = T/resolution
        t = 0:step:T
        
        wd   = sqrt(omega^2-alpha^2)
        disp("== wd ==")
        disp(wd)
        /* Carga */
        disp("\== Carga ==/")
        /* Corrente do Circuito*/
        IK1 = i_ini(1)
        IK2 = (i_deri(1)+IK1*alpha)/wd
        
        disp("== K1 (Corrente) ==")
        disp(IK1)
        disp("== K2 (Corrente) ==")
        disp(IK2)
        
        i_carga    = exp(-alpha*t).*( IK1*cos(wd*t) + IK2*sin(wd*t) )
        
        /* Tensão do Capacitor*/
        VK1 = v_ini(1) - Vf
        VK2 = (v_deri(1)+VK1*alpha)/wd
        
        disp("== K1 (Tensão) ==")
        disp(VK1)
        disp("== K2 (Tensão) ==")
        disp(VK2)
        
        Vc_carga   = Vf + exp(-alpha*t).*( VK1*cos(wd*t) + VK2*sin(wd*t) )
        
        disp("Vc_carga inicial: ", Vc_carga(1)-Vf)
        
        Vr_carga   = i_carga*R
        Vl_carga   = Vc_carga-Vr_carga
        /* Descarga */
        disp("\== Descarga ==/")
        /* Corrente do Circuito*/
        IK1 = i_ini(2)
        IK2 = (i_deri(2)+IK1*alpha)/wd
        
        disp("== K1 (Corrente) ==")
        disp(IK1)
        disp("== K2 (Corrente) ==")
        disp(IK2)
        
        i_descarga    = exp(-alpha*t).*( IK1*cos(wd*t) + IK2*sin(wd*t) )
        /* Tensão do Capacitor*/
        VK1 = v_ini(2)
        VK2 = (v_deri(2)+VK1*alpha)/wd
        disp("== K1 (Tensão) ==")
        disp(VK1)
        disp("== K2 (Tensão) ==")
        disp(VK2)
        
        Vc_descarga   = exp(-alpha*t).*( VK1*cos(wd*t) + VK2*sin(wd*t) )
        
        Vr_descarga   = i_descarga*R
        Vl_descarga   = Vc_descarga-Vr_descarga
    end
    plot(t, Vc_carga)
    plot(t+T, Vc_descarga)
endfunction

R= 2e3
C= 3e-9
L= 10.6e-3

resolution= 1e3
Vf= 4

plot_RLC()
