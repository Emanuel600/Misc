// Template Conversor Buck-Boost
/**/
// Características do Sistema
Vin = 24    // V
Vo  = 40    // V
Io  = 1     // A
f   = 60e3  // Hz
dIL = 40    // %
dVc = 0.4   // %
D   = 50    // %
/**/
// Reajustando variáveis
dIL = dIL/100
dVc = dVc/100
D   =   D/100
// Cálculo de Parâmetros Adicionais
a   = Vo/(Vin*(D/(1-D)))
// Dimensionamento de Componentes
R    = Vo/Io
Lmin = R*(1-D)^2/(2*f)  // Indutor Mínimo para corrente contínua
L    = Lmin*2/dIL       // Indutor para a variação de corrente desajada, assumindo linearidade
C    = Io*D/(f*dVc*Vo)
/**/
printf("==================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("Lp = %0.3g μH\n", 1e6*L/(a^2))
printf("Ls = %0.3g μH\n", 1e6*L)
printf("M  = %0.3g mH\n", 999.5*L/a)
printf("==================\n")
printf("C = %0.3g μF\n", C*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", R)
printf("a  = %0.3g\n", a)
printf("==================\n")
