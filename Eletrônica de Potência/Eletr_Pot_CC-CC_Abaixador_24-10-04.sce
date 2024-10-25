/*
Conversor CC-CC "Abaixador Buck"
*/
// Definição de Características do Sistema
f   = 50e3 // Hz
dIl = 50   // %
dVc = 1    // %
T   = 1    // s
///
Vin = 12
Vo  = 5
Io  = 1
// Reajuste de parâmetros
dIl = dIl/100
dVc = dVc/100
// Cálculo de parâmetros adicionais
I_var = Io*(1 + dIl/2) - Io*(1 - dIl/2)
V_var = Vo*(1 + dVc) - Vo*(1 - dVc)
D = Vo/(Vin*T)
// Dimensionamento de Componentes
L = Vo * T*(1-D)
L = L/(f*dIl*Io)
///
C = I_var * T
C = C/(8*f*dVc*Vo)
// Mostrar Resultados
printf("==================\n")
printf("L = %g H\n", L)  // Era pra ser 116u
printf("C = %g F\n", C)  // Era pra ser 25u
printf("==================\n")
