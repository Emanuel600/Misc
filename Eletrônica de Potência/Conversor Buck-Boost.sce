// Template Conversor Buck-Boost
/**/
// Características do Sistema
Vin = 24    // V
Vo  = 36    // V
Io  = 36/10 // A
f   = 100e3 // Hz
dIL = 70    // %
dVc = 0.4     // %
/**/
// Reajustando variáveis
dIL = dIL/100
dVc = dVc/100
// Cálculo de Parâmetros Adicionais
K   = Vo/Vin    // Razão de Tensões
D   = K/(1+K)
// Dimensionamento de Componentes
R    = Vo/Io
Lmin = R*(1-D)^2/(2*f)  // Indutor Mínimo para corrente contínua
L    = Lmin*2/dIL       // Indutor para a variação de corrente desajada, assumindo linearidade
C    = Io*D/(f*dVc*Vo)
/**/
printf("==================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("L = %0.3g μH\n", L*1e6)
printf("C = %0.3g μF\n", C*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", R)
printf("D  = %0.3g%%, %g\n", D*100, D*360)
printf("==================\n")
