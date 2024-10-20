// Testing Some Stuff
s = %s
K = 1
G1 = K*(s+0.5)
G2 = (1/(s^2*(s+1)))/.(1)
G = G1*G2
H = 1
FTMF = G/.H
// Printing stuff
printf("#=== G1 ===#")
disp(G1)
printf("#=== G2 ===#")
disp(G2)
printf("#=== FTMF ===#")
disp(FTMF)
