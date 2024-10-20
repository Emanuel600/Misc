// ###############
clf()
s=%s; j=%i
G = syslin('c', 4/(s*(s+2)))
H = syslin('c', 1, 1)
SF = G/.H
t=linspace(0, 5, 1000)
// Características Não Compensadas
Kv = 2
z  = 1/sqrt(2)
wn = 10
// Características do sistema compensado
Kpc= 10 // erampa = 10%
zc = sqrt(2)/2
wnc = 10.61 // rad/s
// Sistemas Malha Aberta
S = G*H
// Coeficientes do compensador
Kc = Kpc/Kv
Ms = -zc*wnc + j*wnc*sqrt(1-zc^2)
s=Ms; Mg = 4/(s*(s+2)); s=%s;
[Mg, theta_g] = polar(Mg)
[Ms, theta_s] = polar(Ms)
//
Tz = sin(theta_s) - Kc*Mg*sin(theta_g-theta_s)
Tz = Tz/(Kc*Mg*Ms*sin(theta_g))
Tz = real(Tz)
//
Tp = -(Kc*Mg*sin(theta_s)+sin(theta_g+theta_s))/(Ms*sin(theta_g))
Tp = real(Tp)
//
C = Kc*(Tz*s + 1)/(Tp*s+1)
SC = syslin('c', C*G)
// Teste Com o Ganho
SFC = syslin('c', SC/.H)
printf("!=== Ganho do Compensador !===")
disp(Kc)
printf("!=== Tp do Compensador !===")
disp(Tp)
printf("!=== Tz do Compensador !===")
disp(Tz)
printf("!== C(s) !===")
disp(C)
printf("!=== Sistema Compensado !===")
disp(SFC)
// Resposta ao degrau S1
deff("u=ramp(t)", "u=t")
plot([t', t'],([csim('step',t,SF)', csim('step',t,SFC)']))
title("Resposta ao degrau com e sem compensador")
e = gce()
hl=legend(['Rampa', 'Sem Compensador', 'Com Compensador'], 4)
figure(2)
evans(S)
figure(3)
evans(SC)
//hl=legend(['Sem compensador', 'Com compensador'], 4)
/*
show_window(1)
// Lugar das raízes S1
evans(S1)
title("Lugar das Raízes sem compensador")
show_window(2)
// Diagramas de Bode e Nyquist S1
bode(S1, "rad")
title("Diagrama de Bode sem compenador")
show_window(3)
nyquist(S1)
title("Diagrama de Nyquist sem compensador")
show_window(4)
// Lugar das raízes S2
evans(S2)
title("Lugar das Raízes com compensador")
show_window(5)
// Diagramas de Bode e Nyquist S2
bode(S2, "rad")
title("Diagrama de Bode com compenador")
show_window(6)
nyquist(S2)
title("Diagrama de Nyquist com compensador")
*/
