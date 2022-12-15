/* Testes - FFT */
clf()
t = [0, 0.25, 0.5, 0.75, 1]
// f(t)
w = 2*%pi // f = 1 Hz
f = cos(w*t)
plot(t, f, 'o')
// Ondas
t = linspace(0, 1)
// F(n)
for n=1:6
    wave = cos(n*w*t)
    if(modulo(n,2)==0) then
        plot(t, wave, 'r-')
    else
        plot(t, wave, 'g-')
    end
end
