/*
 * main.c
 *
 *  Created on: 22 de nov de 2024
 *      Author: Emanuel Staub Araldi
 *
 * Implementação de Microcontrolador por Equação Recursiva
 *
 */

// #include "recursivas.h" -> Arquivo incompleto, ignore

#include <stdio.h>

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
    double tf    = 100e-3;  // Tempo Final de Simulação
    double Ref   = 1;       // Assumindo Referência Constante, Pode Ser Lida por ADC
    // Inicializando Variáveis
    int    nf    = (int)(tf / Ts);
    double U[nf];           // Saída Completa
    double Erro[nf];        // Erro Completo
    double ea    = 0;       // Erro Acumulado
    double ua    = 0;       // Saída Acumulada
    double ya    = 0;       // Saída Acumulada
    double Y[nf];           // Saída da Planta
    double y = 0;           // Saída "Amostrada" pelo ADC

    // Inicializando Vetores
    for(int i = 0; i < (sizeof(U) / sizeof(U[0])); i++) {
        U[i] = 0;
        Y[i] = 0;
        Erro[i] = i > 3 ? Ref : 0;
    }
    int j = 0;
    // Simula Até tf, Dentro do Microcontrolador Será Chamado Quando o Buffer Estourar
    for(int n = (sizeof(Cz_a) / sizeof(Cz_a[0])); n < nf; n++) {
        ua = 0;
        ea = 0;

        Erro[n] = Ref - y;
        for(j = 0; j < (sizeof(Cz_b) / sizeof(Cz_b[0])); j++) {
            ea += Cz_b[j] * Erro[n - j];
        }
        for(j = 1; j < (sizeof(Cz_a) / sizeof(Cz_a[0])); j++) {
            ua += Cz_a[j] * U[n - j];
        }
        U[n] = (ea - ua) / Cz_a[0];
        // Lê Y pelo ADC
        ya = 0;
        ua = 0;

        for(j = 0; j < (sizeof(Gz_b) / sizeof(Gz_b[0])); j++) {
            ua += Gz_b[j] * U[n - j];
        }
        for(j = 1; j < (sizeof(Gz_a) / sizeof(Gz_a[0])); j++) {
            ya += Gz_a[j] * Y[n - j];
        }
        Y[n] = (ua - ya) / Gz_a[0];
        y    = Y[n]; // "Leitura" do ADC
        // n ajustado por paridade com o script python
        fprintf(fp, "%d,%g,%g,%g,%g,%g\n", (n - 2), (n - 2) * Ts, Ref, Erro[n], U[n], Y[n]);
    }
    fclose(fp);
}
