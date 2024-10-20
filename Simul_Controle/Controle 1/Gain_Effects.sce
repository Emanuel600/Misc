// Testing Effects of Gain in Control Systems
s=%s;
K = 1
p = 5
G = syslin('c', 1/(s+p))
H = syslin('c', 1, 1)
// Convinience Function
function plot_c(K, G, H)
    f = gcf()
    figure(f.figure_id + 1)
    f.background = -2
    t = linspace(0, (10/(K+p)), 1000)
    // Plotting
    c = (K/(K+p))*(1-%e^(-(K+p)*t))
    cs = csim('step', t, (K*G)/.H)
    plot(t, cs)
    plot(t, c, ':r')
    title("K=" + string(K))
    hl = legend('Simulado', 'Calculado', 4)
endfunction
plot_c(K, G, H)
K = 2
plot_c(K, G, H)
K=5
plot_c(K, G, H)
K=10
plot_c(K, G, H)
K=20
plot_c(K, G, H)
K=50
plot_c(K, G, H)
K=100
plot_c(K, G, H)
// Setting new values
/*
figure(2)
K = 2
t = linspace(0, (10/(K+p)), 1000)
c = (K/(K+p))*(1-%e^(-(K+p)*t))
cs = csim('step', t, (K*G)/.H)
plot(t, cs)
plot(t, c, ':r')
title("K=2")
hl = legend('Simulado', 'Calculado', 4)
// Ramping up
figure(3)
K = 5
t = linspace(0, (10/(K+p)), 1000)
c = (K/(K+p))*(1-%e^(-(K+p)*t))
cs = csim('step', t, (K*G)/.H)
plot(t, cs)
plot(t, c, ':r')
title("K=5")
hl = legend('Simulado', 'Calculado', 4)
// A Bit More
figure(4)
K = 10
t = linspace(0, (10/(K+p)), 1000)
c = (K/(K+p))*(1-%e^(-(K+p)*t))
cs = csim('step', t, (K*G)/.H)
plot(t, cs)
plot(t, c, ':r')
title("K=10")
hl = legend('Simulado', 'Calculado', 4)
// ###
figure(5)
K = 20
t = linspace(0, (10/(K+p)), 1000)
c = (K/(K+p))*(1-%e^(-(K+p)*t))
cs = csim('step', t, (K*G)/.H)
plot(t, cs)
plot(t, c, ':r')
title("K=20")
hl = legend('Simulado', 'Calculado', 4)
// ###
figure(6)
K = 50
t = linspace(0, (10/(K+p)), 1000)
c = (K/(K+p))*(1-%e^(-(K+p)*t))
cs = csim('step', t, (K*G)/.H)
plot(t, cs)
plot(t, c, ':r')
title("K=50")
hl = legend('Simulado', 'Calculado', 4)
// ###
figure(7)
K = 100
t = linspace(0, (10/(K+p)), 1000)
c = (K/(K+p))*(1-%e^(-(K+p)*t))
cs = csim('step', t, (K*G)/.H)
plot(t, cs)
plot(t, c, ':r')
title("K=100")
hl = legend('Simulado', 'Calculado', 4)
*/
