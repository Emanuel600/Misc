/*
Conversor CC-CC "Booster MCC"
*/
// Definição de Características do Sistema
f   = 20e3 // Hz
dIl = 30   // %
dVc = 0.45 // % -> Margem de segurança adicionada
T   = 1    // s
///
Vin = 12
Vo  = 18
Po  = 20
// Reajuste de parâmetros
dIl = dIl/100
dVc = dVc/100
// Cálculo de parâmetros adicionais
Io  = Po/Vo
D = 1 - Vin/Vo
Iin = Io*Vo/Vin
I_var = Io*(1 + dIl/2) - Io*(1 - dIl/2)
V_var = Vo*(1 + dVc) - Vo*(1 - dVc)
// Dimensionamento de Componentes
L = Vin * T*D
L = L/(f*dIl*Iin)
///
C = Io * D * T
C = C/(f*dVc*Vo)
//
R = Vo/Io
// Mostrar Resultados
printf("==================\n")
printf("L = %g μH\n", L*1e6)
printf("C = %g μF\n", C*1e6)
printf("R = %g Ω\n", R)
printf("D = %gº\n", D*360)
printf("==================\n")
