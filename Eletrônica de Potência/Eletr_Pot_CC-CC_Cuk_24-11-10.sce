// Template Conversor cuck
/*
" TheCuk converter of Fig. 6-13 (a) has an input of 20 V and supplies an output of
1.0 A at 10 V. The switching frequency is 100 kHz. Determine the values of L1
Problems 263 and L2 such that the peak-to-peak variation in inductor currents 
is less than 10 percent of the average."
*/
// Características do Sistema
Vin = 20    // V
Vo  = 10    // V
Io  = 1     // A
f   = 100e3 // Hz
dIL = 8     // %
dVo = 5     // %
/**/
// Reajustando variáveis
dIL = dIL/100
dVo = dVo/100
// Cálculo de Parâmetros Adicionais
K    = Vo/Vin    // Razão de Tensões
D    = K/(1+K)
Iin  = Io*Vo/Vin // Po = Pin
// Dimensionamento de Componentes
R    = Vo/Io
L1   = Vin*D/(2*dIL*Iin*f) // Variação de corrente é específica ao indutor calculado
L2   = Vin*D/(2*dIL*Io*f)
C2   = (1-D)/(16*L2*dVo*f^2)
C1   = D/(2*R*dVo*f)
/**/
printf("==================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("L1 = %0.3g μH\n", L1*1e6)   // Indutor de Entrada
printf("C1 = %0.3g μF\n", C1*1e6)   // Capacitor de Acoplamento
printf("\n")
printf("L2 = %0.3g μH\n", L2*1e6)   // Indutor de Saída
printf("C2 = %0.3g μF\n", C2*1e6)   // Capacitor de Saída
printf("==================\n")
printf("Rl = %g Ω\n", R)
printf("D  = %g\n", D*360)
printf("==================\n")
