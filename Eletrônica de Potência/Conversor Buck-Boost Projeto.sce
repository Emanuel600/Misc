// Template Conversor Buck-Boost
/**/
// Características do Sistema
Vin = 12     // V
Vo  = 15     // V
Io  = 1      // A
f   = 1/15e-6// Hz
dIL = 70     // %
dVc = 1      // %
/**/
// Reajustando variáveis
dIL = dIL/100
dVc = dVc/100
Vin = Vin-0.5 // Compensando Perda no Diodo
// Cálculo de Parâmetros Adicionais
D   = Vo/(Vin + Vo)
Iin = (Vo*Io/Vin)*(1 + 10e-2) // Compensando Perda de Potência
// Dimensionamento de Componentes
R    = Vo/Io
// Il   = Vin*D/(R*(1-D)^2) != Iin
// L    = (R*(1-D)^2)/(f*dIL*Il)
L    = (R*(1-D)^2)/(f*dIL)
C    = Io*D/(f*dVc*Vo)
// Corrente e Tensão Máximas na Chave e no Diodo
//! Iin/(DT) é a área da corrente na chave, resultando em um valor médio quando multiplicado por T !\\
Is   = (1+dIL/2)*Iin/D
Id   = Is
////
Vs   = (Vin + Vo)*(1+dVc/2)
Vd   = Vs
/**/
printf("==================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("L = %0.3g μH\n", L*1e6)
printf("C = %0.3g μF\n", C*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", R)
printf("D  = %0.3g%%, %g\n", D*100, D*360)
printf("==================\n")
printf("Is = %0.3g A\n", Is)
printf("Vs = %0.3g V\n", Vs)
printf("------------------\n")
printf("Id = %0.3g A\n", Id)
printf("Vd = %0.3g V\n", Vd)
printf("==================\n")
printf("Po = %0.3g W\n", Vo*Io)
printf("==================\n")
