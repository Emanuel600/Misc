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
f      = 200e3  // Hz
dIl    = 200    // %
Io_var = 0.25   // A
// Variação de tensão de saída não estabelecida
///
Vin = 12.5
Vo  = 5
Io  = 0.75
Vs_swing = 2.5      // V - Variação da tensão de entrada
// Reajuste de parâmetros
dIl = dIl/100
Vs_swing = Vs_swing/Vin // %
// Cálculo de parâmetros adicionais
Rl  = Vo/Io                 // Resistência da Carga
dVc = Io_var/Io - Vs_swing  // 1/100 %
I_var = Io*(1 + dIl/2) - Io*(1 - dIl/2) // Variação de corrente no indutor
D = Vo./(Vin)
Rl  = Vo/Io         // Resistência da Carga
// Dimensionamento de Componentes
L = Vo * (1-D)
L = L./(f*dIl*Io)
///
C = I_var
C = C./(8*f*dVc*Vo)
// Mostrar Resultados
printf("==================\n")
printf("L = %g μH\n", L*1e6)    // Simulado como 10.325u
printf("C = %g μF\n", C*1e6)
printf("==================\n")
printf("Rl = %g Ω\n", Rl)
printf("==================\n")
