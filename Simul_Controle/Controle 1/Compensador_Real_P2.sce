clf()
s=%s; j=%i
G = syslin('c', 4/(s*(s+2)))
H = syslin('c', 1, 1)
t=linspace(0, 15, 1000)
// Características do Circuito do Compensador Real
R1 = 1.5e3; R2 = 2.2e3; R3 = 100; R4 = 1.3e3
C1 = 100e-6; C2=10e-6
Kc = (R2*R4)/(R1*R3)
Tz = R1*C1
Tp = R2*C2
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
plot([t', t', t'],([t', csim(ramp,t,SF)', csim(ramp,t,SFC)']))
title("Resposta à rampa com e sem compensador")
e = gce()
hl=legend(['Rampa', 'Sem Compensador', 'Com Compensador'], 4)
figure(2)
evans(S)
figure(3)
evans(SC)
