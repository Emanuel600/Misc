// Ajuste PID ZN MF
s=%s; clf()
G = 150/((s+1)*(s+2)*(s+10))
Gs = syslin('c', G)
H  = syslin('c', 1, 1)
// Plota Resposta de Malha Aberta
t = linspace(0, 5, 1000)
[Mg, fφ] = g_margin(Gs/.H)
// Encontra Constantes Pela Tabela (ISA)
/* Tabela Normal
*     Kp        Ti        Td
* P   0.5Kcr    inf       0
* PI  0.45Kcr   Pcr/1.2   0
* PID 0.6Kcr    Pcr/2     Pcr/8
* Tabela Reajustada
*                Kp        Ti        Td
* PID Clássico   0.6Kcr    Pcr/2     Pcr/8
* Pes Int Rule   0.7Kcr    Pcr/2.5   3Pcr/20
* Ty-Luy         Kcr/3.2   2.2Pcr    Pcr/6.3
* < OS           Kcr/3     Pcr/2     Pcr/3
* 0 OS           0.2Kcr    Pcr/2     Pcr/3
*/
Kcr = 10^(Mg/20)
Pcr = fφ
Kp = Kcr/3
Ti = Pcr/2
Td = Pcr/3
ac = 0.125
// Ajuste Fino
Ti = Ti*(1+0.7)  // Melhorar tempo de subida
Td = Td*(1+0.5)  // Reduzir sobresinal e melhorar tempo de acomodação
Kp = Kp*(1+0.3)  // Melhorar tempo de subida
p  = 1/(ac*Td)   // Torna o Sistema Realizavel
//
Gc = Kp*(1+p*Td)*(s^2+((1+p*Ti)/(Ti*(1+p*Td)))*s+(p/(Ti*(1+p*Td))))/(s*(s+p))
//
GC = syslin('c', Gc)
plot([t', t'], [csim('step', t, G/.H)', csim('step', t, (G*GC)/.H)'])
e = gce()
hl=legend(['Sem Controlador', 'Com Controlador'], 4)
