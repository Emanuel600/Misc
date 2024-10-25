// Template Conversor Buck-Boost
/**/
// Características do Sistema
Vin = 12    // V
Vo  = 5     // V
Io  = 1     // A
f   = 80e3  // Hz
dIL = 80    // %
dVc = 1     // %
/**/
// Reajustando variáveis
dIL = dIL/100
dVc = dVc/100
// Cálculo de Parâmetros Adicionais
K   = Vo/Vin    // Razão de Tensões
D   = K/(1+K)
Iin = Vo*Io/Vin
// Dimensionamento de Componentes
Rl   = Vo/Io
L1   = Vin*D/(2*dIL*Iin*f)
L2   = Vin*D/(2*dIL*Io*f)
C1   = Io*D/(2*f*dVc*Vo)
C2   = D/(2*f*dVc)
/**/
printf("==================\n")
printf("L1 = %0.3g μH\n", L1*1e6)
printf("C1 = %0.3g μF\n", C1*1e6)
printf("==================\n")
printf("L2 = %0.3g μH\n", L2*1e6)
printf("C2 = %0.3g μF\n", C2*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", Rl)
printf("D  = %g\n", D*360)
printf("==================\n")
