5 // Ajuste PID
s=%s; clf()
G = 150/((s+1)*(s+2)*(s+10))
Gs = syslin('c', G)
// Plota Resposta de Malha Aberta
t = linspace(0, 5, 1000)
y = csim('step', t, Gs)
//plot(t, y)
// Marcando Pontos
P = [0.383, 0.49]
//P2 = [0.382, 0.486]
L = 0.3
a = P(2)/(P(1)-L)
//plot(t, a*(t-L), 'r--') // Confere valores
tau = (y($)/a)
printf("Fator de controlabilidade: %g", L/tau)
// Encontra Constantes Pela Tabela (ISA)
Kp = 1.2 * tau/L
Ti = 2*L
Td = L/2
ac = 0.125
// Ajuste Fino
Ti = Ti*(1+0.5)  // Reduzir sobresinal
Td = Td*(1+0.8)   // Reduzir sobresinal
Kp = Kp*(1-0.6)   // Reduzir sobresinal
p  = 1/(ac*Td)
//
Gc = Kp*(1+p*Td)*(s^2+((1+p*Ti)/(Ti*(1+p*Td)))*s+(p/(Ti*(1+p*Td))))/(s*(s+p))
//
GC = syslin('c', Gc)
H  = syslin('c', 1, 1)
plot([t', t'], [csim('step', t, G/.H)', csim('step', t, (G*GC)/.H)'])
e = gce()
hl=legend(['Sem Controlador', 'Com Controlador'], 4)
