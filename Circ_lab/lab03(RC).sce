/* == Ensaio 1 == */
// Valores estáticos:
T= 6e-3     // Período (~12 tau)
Vs= 5       // Tensão da fonte
V0= 0       // Começa descarregado => Não precisa ser adicionado na fórmula
R= 1.8e3    // Resistência do circuito (tanto no período de carga, quanto no de descarga)
C= 270e-9   // Capacitância do circuito
// Valores calculados (Carga):
tau= R*C    // Constante de tempo (~486 ms)
/* Criando Gráfico (Carga)*/
// Elementos básicos
n= 1e6      // Número depedaços em que o gráfico vai ser "dividido"
t0= 0       // Tempo inicial
tf= T/2     // Tempo final
a = gca()   // Recebe eixos
// Criando vetores
t= linspace(t0, tf, n)
e= exp(-t./tau)        // Para poder reutilizar
Vc= Vs.*(1-e)
Vr= Vs-Vc
a.data_bounds= [t(1) t($) -Vs Vs+1] // Seta limites nos eixos 'x' e 'y'
// Plotando valores
plot(t,Vc)
plot(t, Vr, color= 'r')
plot([t0, tf], [Vs, Vs], color= 'y')

/* Criando Gráfico (Desarga)*/
// Elementos básicos
V0= Vc($) // Tensão inicial é o último elemento do y anterior
// Criando vetores
t= linspace(tf, T, n)
Vc= V0.*e
Vr= -Vc     // Para concordar com a ordem das sondas do osciloscópio
plot(t, Vc)
plot(t, Vr, color='r')
plot([tf, T], [0, 0], color= 'y')
// Criando a legenda
legend(["Tensão do Capacitor" ; "Tensão do Resistor (Corrente)" ; "Tensão da Fonte"])
