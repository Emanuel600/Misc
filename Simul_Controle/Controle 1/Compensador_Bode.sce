s=%s
G=10/(s*(s+1))
G = syslin('c', G)
H = 1
// Características Desejadas
Kv_d = 20
Mf_d = 50+0 // graus
// Caracerísticas Atuais
Kv = 10
// Características do Compensador
Kc = Kv_d/Kv
[Mf_g, wg_g] = p_margin(Kc*G) // Margens com o ganho do compensador
wg_g = 2*%pi*wg_g // Hz to rad/s
fi = Mf_d - Mf_g
a = (1+sind(fi))/(1-sind(fi))
[Mf_K, wg_K] = p_margin(a*G) // Novas margens com o ganho de a
wg_K = 2*%pi*wg_K // Hz to rad/s
T = 1/(sqrt(a)*wg_K)
// Sistema Compensado
C = Kc*(T*a*s+1)/(T*s+1)
Gc = G*C
// Fechando os sistemas e simulando seus valores:
Gc = syslin('c', Gc)
bode(G, "rad")
title("Bode sem Compensador")
figure(2)
gcf().background = -2
bode(Gc)
title("Bode com Compensador")
//
S = syslin('c', (G/.H))
Sc = syslin('c', Gc/.H)
t = 0:0.01: 10
figure(3)
gcf().background = -2
plot([t', t'], [csim('step', t, S)', csim('step', t, Sc)'])
e = gce()
hl=legend(['Sem Compensador', 'Com Compensador'], 4)
