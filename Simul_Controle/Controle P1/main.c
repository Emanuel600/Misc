/*
 * main.c
 *
 *  Created on: 22 de nov de 2024
 *      Author: Emanuel Staub Araldi
 *
 * Implementação de Microcontrolador por Equação Recursiva
 *
 */

#include <stdio.h>

#include "recursivas.h"

int main()
{
    FILE* fp;
    fp = fopen("Simulacao em C.csv", "w+");
    fprintf(fp, "n,t,Ref,Erro,U,Y\n");

    const double Gz_a[] = {1, -1.43163444, 0.69070022};
    const double Gz_b[] = {0.13758882, 0.12147697};

    double K = 1.3232630361853022;
    const double Cz_a[] = {1, -1.25153218, 0.25153218};
    const double Cz_b[] = {1 * K, -1.43163444 * K, 0.69070022 * K};

    float  Ts    = 2.986e-3;// Taxa de Amostragem
    double tfin  = 100e-3;  // Tempo Final de Simulação
    int    nf    = (int)(tfin / Ts);
    double Ref   = 1;       // Assumindo Referência Constante, Pode Ser Lida por ADC
    double Erro  = 0;
    double U     = 0;
    double Y     = 0;

    TransferFunction Cz = tf(Cz_b, Cz_a, Ts);
    LTI_System C = lti_Init(&Cz, 3, 3);

    TransferFunction Gz = tf(Gz_b, Gz_a, Ts);
    LTI_System G = lti_Init(&Gz, 2, 3);
    // Simulando Aplicação Real do Filtro
    for(int n = C.y.size; n < nf; n++) {
        Ref  = 1;                   // Lê ADC?
        Erro = Ref - Y;
        U    = lti_rtf(&C, Erro);
        Y    = lti_rtf(&G, U);      // "Lê ADC"
        fprintf(fp, "%d,%g,%g,%g,%g,%g\n", (n - 1), (n - 1) * Ts, Ref, Erro, U, Y);
    }
    fclose(fp);
}
