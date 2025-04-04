// Template Conversor Buck-Boost
/**/
// Características do Sistema
Vin  = 9     // V
Vo   = 2.7   // V
Io   = 1     // A
f    = 300e3 // Hz
dIL  = 40    // %
dILi = 40    // %
dVc  = 2     // %
/**/
// Reajustando variáveis
dIL  = dIL/100
dVc  = dVc/100
dILi = dILi/100
// Cálculo de Parâmetros Adicionais
K   = Vo/Vin    // Razão de Tensões
D   = K/(1+K)
Iin = Vo*Io/Vin
// Dimensionamento de Componentes
Rl   = Vo/Io
L1   = Vin*D/(dILi*Iin*f)
L2   = Vin*D/(dIL*Io*f)
C1   = Io*D/(f*dVc*Vo)
C2   = D/(f*Rl*dVc)
// Correntes e Tensões Máximas
Is   = (Iin + Io)*(1+dILi/2)
Id   = (Iin + Io)*(1+dIL/2)

Vs   = (Vo+Vin)*(1+dVc)
Vd   = (Vo+Vin)*(1+dVc)
/**/
printf("==================\n")
printf("L1 = %0.3g μH\n", L1*1e6)
printf("C1 = %0.3g μF\n", C1*1e6)
printf("==================\n")
printf("L2 = %0.3g μH\n", L2*1e6)
printf("C2 = %0.3g μF\n", C2*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", Rl)
printf("D  = %0.3g%% %g\n", D*100, D*360)
printf("==================\n")
printf("Is = %0.3g A\n", Is)
printf("Id = %0.3g A\n", Id)
printf("------------------\n")
printf("Vs = %0.3g V\n", Vs)
printf("Vd = %0.3g V\n", Vd)
printf("==================\n")
