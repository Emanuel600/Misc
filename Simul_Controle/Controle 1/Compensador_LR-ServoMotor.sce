// Compensador p/ Servo Motor
clf()
s=%s; j=%i
// Realimentação
G = syslin('c', 1/s)
H = syslin('c', 1, 1)
// Constantes de Máquina
J = 2.5e-3
B = 5e-3
// Cálculo de z e wn
OS = log(0.2)
Tp = 1
z  = -OS/(sqrt(%pi^2+OS^2))
/*
          %pi
Tp = --------------
     wn*sqrt(1-z^2)
     
          %pi
wn = --------------
     Tp*sqrt(1-z^2)
*/
wn = %pi/(Tp*sqrt(1-z^2))
/*
      Km
Ma = ----
     Js+B
     
Hm = Kt
     
          Km
M  = -----------
     J*s+B+Kt*Km
    
     1
G  = -
     s
      
H  = 1
      
           Km
MG = --------------
     s(J*s+B+Kt*Km)
     
             Km            1/J          Km/J
C  = ------------------- * --- = ----------------------
     s(J*s+B+Kt*Km) + Km   1/J  s(s+B/J+Kt*Km/J) + Km/J
     
Km = J*wn^2
Kt*Km = ((J*zeta*(2*wn))-B)
--- P/ zeta e omega ---
Km = J*wn^2
Kt = ((J*zeta*(2*wn))-B)/Km
*/
Km = J*wn^2
Kt = ((J*z*(2*wn))-B)/Km
// Bloco do Motor
M = Km/(J*s+B+Kt*Km)
// Sistema
Gm = G*M
C  = Gm/.H
disp(C)
t=linspace(0, 5, 1000)
Servo_Degrau = csim('step',t,C)
// Características Não Compensadas
Kv = J*Km/((B+Kt*Km)+Km)
// Características do sistema compensado
Kpc = Kv*2
Tpc = 0.75
OSc = log(0.1)
zc  = -OSc/(sqrt(%pi^2+OSc^2))
wnc = %pi/(Tpc*sqrt(1-zc^2))
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
Gc = Kc*(Tz*s + 1)/(Tp*s+1)
SC = syslin('c', Gc*Gm)
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
plot([t', t'],([Servo_Degrau', csim('step', t, SFC)']))
title("Resposta ao degrau do motor")
e = gce()
hl=legend(['Sem Compensador', 'Com Compensador'], 4)
/*
figure(2)
evans(S)
figure(3)
evans(SC)
*/
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
