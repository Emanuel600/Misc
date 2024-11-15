/*
Conversor CC-CC "Abaixador Buck"
*/
// Definição de Características do Sistema
f   = 50e3 // Hz
dIl = 80   // %
dVc = 1    // %
///
Vin = 24
Vo  = 15
Io  = 2
// Reajuste de parâmetros
dIl = dIl/100
dVc = dVc/100
// Cálculo de parâmetros adicionais
Iin   = Vo*Io/Vin
I_var = Io*(1 + dIl/2) - Io*(1 - dIl/2)
V_var = Vo*(1 + dVc) - Vo*(1 - dVc)
D = Vo/(Vin)
// Dimensionamento de Componentes
L = Vo * (1-D)
L = L/(f*dIl*Io)
///
C = I_var
C = C/(8*f*dVc*Vo)
//
R = Vo/Io
// Correntes e Tensões Máximas no Diodo e na Chave
Is = Io*(1+dIl/2)
Id = Is
////
Vs = Vin*(1+dVc/2)
Vd = Vs
// Mostrar Resultados
printf("==================\n")
printf("L = %g uH\n", 1e6*L)
printf("C = %g uF\n", 1e6*C)
printf("R = %g Ω\n", R)
printf("==================\n")
printf("D = %0.3g%%, %0.3g\n", D*100, D*360)
printf("==================\n")
printf("Is = %0.3g A\n", Is)
printf("Vs = %0.3g V\n", Vs)
printf("------------------\n")
printf("Id = %0.3g A\n", Id)
printf("Vd = %0.3g V\n", Vd)
printf("==================\n")
