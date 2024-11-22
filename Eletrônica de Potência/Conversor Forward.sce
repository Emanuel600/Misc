/*
Conversor CC-CC "Abaixador Buck"

Questão 6.10 do Hart:
"
  Um conversor Buck tem uma tensão que varia entre entre 10 e 15 V e uma corrente
na carga que varia entre 0.5 e 1.0 A. A tensão na saída é 5V. Para uma frequência de
chaveamento de 200 kHz, determine a indutância mínima para fornecer uma corrente no
modo de condução contínua para toda possibilidade de funcionamento
"
*/
// Definição de Características do Sistema
Vin    = 400    // V
Vo     = 48     // V
Io     = 10     // A
f      = 20e3   // Hz
dIl    = 60     // %
dVc    = 0.5    // %
D      = 40     // %
// Reajuste de parâmetros
dIl = dIl/100
dVc = dVc/100
D   =   D/100
// Cálculo de parâmetros adicionais
Rl      = Vo/Io                            // Resistência da Carga
I_var   = Io*(1 + dIl/2) - Io*(1 - dIl/2)   // Variação de corrente no indutor
a       = Vo/(Vin*D)
Vin     = a*Vin
Iin     = Vo*(a*Io)/Vin
Im      = Iin*5e-2
// Dimensionamento de Componentes
Lx  = Vo*(1-D)/(f*dIl*Io)
Im  = Im*(1 + dIl/2) - Im*(1 - dIl/2)
Lmp = Vin*D/(Im*f)  // Primário
Lms = Lmp*(a^2)     // Secundário
///
C = I_var
C = C/(8*f*dVc*Vo)
// Mostrar Resultados
printf("==================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("Lx  = %0.3g μH\n", Lx*1e6)
printf("Lmp = %0.3g mH\n", Lmp*1e3)
printf("Lms = %0.3g mH\n", Lms*1e3)
printf("C   = %0.3g μF\n", C*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", Rl)
printf("a  = %0.3g\n", a)
printf("D  = %0.3g%%, %gº\n", D*100, D*360)
printf("==================\n")
