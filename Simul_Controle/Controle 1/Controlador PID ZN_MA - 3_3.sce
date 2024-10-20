// Compensador p/ 3.3
clf()
s=%s; j=%i
// Realimentação
G = syslin('c', 20/(s^2+17*s+10))
H = syslin('c', 1, 1)
/*
        20
G = ----------- => K=2, wn = sqrt(10), zeta = 17/(2*wn), Kcr inexistente e sem integrador: ZN de MA
    s^2+17*s+10
    
H = 1
    
*/
t=linspace(0, 3.5, 1000)
Resposta_Malha_Aberta = csim('step', t, G)
L = 0.04
a = 0.061/(0.1-L)
/*
T*a = 2
*/
T = Resposta_Malha_Aberta($)/a
Kp = 1.2 * T/L
Ti = 2*L
Td = L/2
ac = 0.125
// Ajuste Fino
Ti = Ti*(1+0.5)   // Reduzir sobresinal
Td = Td*(1+0.7)   // Reduzir sobresinal
Kp = Kp*(1+0.0)   // Reduzir sobresinal
p  = 1/(ac*Td)    // Torna o Sistema Realizavel
//
G_PID = ((Kp*(1+p*Td))*(s^2+((1+p*Ti)/(Ti*(1+p*Td)))*s+(p/(Ti*(1+p*Td)))))/(s*(s+p))
//
G_PID = syslin('c', G_PID)
C_PID = (G_PID*G)/.H
plot([t', t'],([csim('step', t, G/.H)', csim('step', t, C_PID)']))
e = gce()
hl=legend(['Sem PID', 'Com PID'], 4)
// Plota
/* Prova Real
plot([t', t', T*(t./t)'],([Resposta_Malha_Aberta', (a*(t-L))', t']))
title("Resposta de Malha Aberta")
e = gce()
hl=legend(['Malha Aberta', 'Tangente'], 4)
*/
