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
R    = Vo/Io
L1   = Vin*D/(2*dIL*Iin*f)
L2   = Vin*D/(2*dIL*Io*f)
C1   = Io*D/(2*f*dVc*Vo)
C2   = D/(2*f*dVc)
/**/
printf("==================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("L = %0.3g μH\n", L*1e6)
printf("C = %0.3g μF\n", C*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", Rl)
printf("D  = %g\n", D*360)
printf("==================\n")
