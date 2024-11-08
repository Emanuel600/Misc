/*
Conversor CC-CC "Booster MCC"
*/
// Definição de Características do Sistema
f   = 300e03// Hz
dIl = 50    // %
dVc = 1     // % -> Margem de segurança adicionada
///
Vin = 5
Vo  = 15
Po  = 25
// Reajuste de parâmetros
dIl = dIl/100
dVc = dVc/100
// Cálculo de parâmetros adicionais
Io    = Po/Vo
D     = 1 - Vin/Vo
Iin   = Io*Vo/Vin
I_var = Io*(1 + dIl/2) - Io*(1 - dIl/2)
V_var = Vo*(1 + dVc/2) - Vo*(1 - dVc/2)
// Dimensionamento de Componentes
L = Vin * D
L = L/(f*dIl*Iin)
///
C = Io * D
C = C/(f*dVc*Vo)
//
R = Vo/Io
// Cálculo de Correntes e Tensões Máximas no Conversor
Is = Iin*(1+dIl/2)
Id = Is
Vs = Vo*(1+dVc/2)
Vd = Vo*(1+dVc/2)
// Mostrar Resultados
printf("==================\n")
printf("L = %g μH\n", L*1e6)
printf("C = %g μF\n", C*1e6)
printf("R = %g Ω\n", R)
printf("D = %0.3g%%, %gº\n", 100*D, D*360)
printf("==================\n")
printf("Is = %0.3g\n", Is)
printf("Vs = %0.3g\n", Vs)
printf("\n")
printf("Id = %0.3g\n", Id)
printf("Vd = %0.3g\n", Vd)
printf("==================\n")
