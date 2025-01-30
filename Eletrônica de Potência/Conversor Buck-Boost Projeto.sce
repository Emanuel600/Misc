// Template Conversor Buck-Boost
/**/
// Características do Sistema
Vin = 24     // V
Vo  = 12     // V
Io  = 2      // A
f   = 40e3   // Hz
L   = 530    // H
C   = 470    // F
η   = 100    // %
/**/
// Reajustando variáveis
L   = L*1e-6
C   = C*1e-6
η   = η/100
D   = (Vo)/(Vin+(Vo))
// Cálculo de Parâmetros Adicionais
Iin = Vo*Io/(η*Vin) // Compensando Perda de Potência
// Dimensionamento de Componentes
R    = Vo/Io
// Il   = Vin*D/(R*(1-D)^2) != Iin
// L    = (R*(1-D)^2)/(f*dIL*Il)
dIl    = D*Vin/(f*L*(Iin+Io))
dVc    = (Io*D/(f*C*Vo)) // Compensa perdas de Rendimento
// Corrente e Tensão Máximas na Chave e no Diodo
//! Iin/(DT) é a área da corrente na chave, resultando em um valor médio quando multiplicado por T !\\
Is   = (1+dIl/2)*Iin/D
Id   = Is
////
Vs   = (Vin + Vo)*(1+dVc/2)
Vd   = Vs
/**/
printf("==================\n")
printf("dIl = %0.3g %%\n", dIl*100)
printf("dVc = %0.3g %%\n", dVc*100)
printf("==================\n")
printf("Rl = %g Ω\n", R)
printf("D  = %0.3g%%, %g\n", D*100, D*360)
printf("==================\n")
printf("Iin = %0.3g A\n", Iin)
printf("Is  = %0.3g A\n", Is)
printf("Vs  = %0.3g V\n", Vs)
printf("------------------\n")
printf("Id = %0.3g A\n", Id)
printf("Vd = %0.3g V\n", Vd)
printf("==================\n")
printf("Po = %0.3g W\n", Vo*Io)
printf("==================\n")
