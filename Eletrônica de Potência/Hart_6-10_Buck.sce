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
dVc    = 5      // %
// Variação de tensão de saída não estabelecida
///
Vin = [10, 15]
Vo  = 5
Io  = [0.5, 1.0]
// Reajuste de parâmetros
dIl = dIl/100
// Cálculo de parâmetros adicionais
Rl      = Vo./Io                            // Resistência da Carga
I_var   = Io*(1 + dIl/2) - Io*(1 - dIl/2)   // Variação de corrente no indutor
D       = Vo./(Vin)
// Dimensionamento de Componentes
/*
     D(1), Io(1)  |  D(1), Io(2)
L  =                            
     D(2), Io(1)  |  D(2), Io(2)
*/
L      = zeros(2, 2)
L(1,:) = ones(1, 2)* Vo * (1-D(1))
L(2,:) = ones(1, 2)* Vo * (1-D(2))
L(:,1) = L(:,1)./(f*dIl*Io(1))
L(:,2) = L(:,2)./(f*dIl*Io(2))
///
C = I_var
C = C./(8*f*dVc*Vo)
// Mostrar Resultados
printf("====================================\n") // Simulado para o indutor: {9.23μ, 1.77u}
printf("L (μH):\n")
printf("       0.5\t1.0\tA\n")
printf(" 10 V |%0.3g\t%0.3g|\n", 1e6*L(1, 1), 1e6*L(1, 2))
printf(" 15 V |%0.3g\t%0.3g|\n", 1e6*L(2, 1), 1e6*L(2, 2))
printf("\n")
printf("C = %0.3g nF\n", max(C)*1e9)
printf("====================================\n")
printf("Rl = {%g, %g} Ω\n", Rl(1), Rl(2))
printf("D  = {%g, %g} º\n", D(1)*360, D(2)*360)
printf("====================================\n")
printf("\nMaior valor de L para condução mínima: %0.3g μH\n", 1e6*max(L)) // Simulado: 13.5 μH
