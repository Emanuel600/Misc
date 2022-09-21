/* == Ensaio 2 == */
// Valores estáticos:
T=  37.4e-6  // Período (~12 tau)
Vs= 5       // Tensão da fonte
R=  1.8e3    // Resistência do circuito (tanto no período de carga, quanto no de descarga)
L=  5.6e-3   // Capacitância do circuito
// Valores calculados (Carga):
tau= L/R    // Constante de tempo (~3.11 us)
Im=  Vs/R   // Corrente máxima do circuito
/* Criando Gráfico (Carga)*/
// Elementos básicos
n =1e6      // Número depedaços em que o gráfico vai ser "dividido"
t0= 0       // Tempo inicial
tf= T/2     // Tempo final
a = gca()   // Recebe eixos
// Criando vetores
t= linspace(t0, tf, n)
e= exp(-t./tau)        // Para poder reutilizar
Il= Im.*(1-e)
Vr= Il.*R
Vl= Vs-Vr
a.data_bounds= [t(1) t($) 0 Vs+1] // Seta limites nos eixos 'x' e 'y'
// Plotando valores
plot2d(t, Vl, 2)                // Azul
plot2d(t, Vr, 5)                // Vermelho
plot2d([t0, tf], [Vs, Vs], 7)   // Amarelo
/* Criando Gráfico (Desarga)*/
// Elementos básicos
I0= Il($) // Corrente inicial é o último elemento do y anterior
// Criando vetores
t= linspace(tf, T, n)
Il= I0.*e
Vr= Il*R  // Para concordar com a ordem das sondas do osciloscópio
Vl= -Vr
plot2d(t, Vl, 2)             // Azul
plot2d(t, Vr, 5)             // Vermelho
plot2d([tf, T], [0, 0], 7)   // Amarelo
// Nomeando eixos
xlabel("t (s)")
ylabel("Tensão nos elementos (V)")
// Adicionando legendas
legend(["Tensão do Indutor" ; "Tensão do Resistor (Corrente)" ; "Tensão da Fonte"])
