/*
 * Coeficientes.h
 *
 *  Created on: 22 de nov de 2024
 *      Author: Aluno
 */

#ifndef RECURSIVAS_H_
#define RECURSIVAS_H_

// Função de Transferência
typedef struct TransferFunction {
    unsigned short int size;
    double Ts; // Taxa de amostragem, em segundos
    double* a; // Polos
    double* b; // Zeros
} TransferFunction;

// Ring Buffer
typedef struct buffer {
    double* data;
    int size;
} buffer;

// Sistema Linear Invariante no Tempo
typedef struct LTI_System {
    buffer x;
    buffer y;

    TransferFunction* tf;    // Função de Transferência
} LTI_System;

// Cria Função de Transferência de Polos e Zeros
TransferFunction pz2tf(double Ts);

inline void tf_seta(TransferFunction* tf, double* a)
{
    tf->a = a;
}

inline void tf_setb(TransferFunction* tf, double* b)
{
    tf->b = b;
}

inline void tf_setTs(TransferFunction* tf, double Ts)
{
    tf->Ts = Ts;
}

// Cria fun��o de Transfer�ncia a partir de a e b
TransferFunction tf(const double* b, const double* a, double Ts);

// Resposta ao Degrau
double* tf_GetStepResp(TransferFunction* tf, int nf);

// Resposta ao Impulso
double* tf_GetImpResp(TransferFunction* tf, int nf);

// Implementa Controlador Digital e Calcula Sa�da ao Degrau
double* tf_GetFeedbackStepResp(TransferFunction* Cz, TransferFunction* Gz);

// Inicia "Objeto" LTI
LTI_System lti_Init(TransferFunction* tf, int size_x, int size_y);

// Inicia "Objeto" buffer
buffer buffer_init(int size);

// Adiciona ao Ring Buffer do LTI
void buffer_push(buffer* buffer, double data);

// Aplica Filtro em Tempo Real - Retorna Y[n]
double lti_rtf(LTI_System* sys, double x);

#endif /* RECURSIVAS_H_ */
