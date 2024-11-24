/*
 * recursivas.c
 *
 *  Created on: 22 de nov de 2024
 *      Author: Aluno
 */

#include <stdio.h>
#include <stdlib.h>

#include "recursivas.h"

TransferFunction tf(const double* b, const double* a, double Ts)
{
    TransferFunction tf;
    tf.a  = a;
    tf.b  = b;
    tf.Ts = Ts;
    return tf;
}

buffer buffer_init(int size)
{
    buffer buff;
    buff.size = size;
    buff.data = (double*) malloc(buff.size * sizeof(double));

    for(int i = 0; i < size; i++) {
        buff.data[i] = 0;
    }

    return buff;
}

LTI_System lti_Init(TransferFunction* tf, int size_x, int size_y)
{
    LTI_System sys;
    sys.tf          = tf;

    sys.y           = buffer_init(size_y);
    sys.x           = buffer_init(size_x);

    return sys;
}

void buffer_push(buffer* buffer, double data)
{
    for(int i = 0; i < buffer->size - 1; i++) {
        buffer->data[i] = buffer->data[i + 1];
    }
    buffer->data[buffer->size - 1] = data;
}

double lti_rtf(LTI_System* sys, double x)
{
    double ac_x     = 0;
    double ac_y     = 0;

    buffer* buff_x  = &sys->x;
    buffer* buff_y  = &sys->y;

    int    ny       = buff_y->size;
    int    nx       = buff_x->size;

    double y = 0;

    buffer_push(buff_x, x);

    for(int j = 1; j < nx + 1; j++) {
        ac_x += sys->tf->b[j - 1] * buff_x->data[nx - j];
        printf("b[%d] * %g + ", j - 1, buff_x->data[nx - j]);
    }
    printf("-(");
    for(int j = 2; j < ny + 1; j++) {
        // buffer[+1] devido à falta de y[n]*a[0]
        ac_y += sys->tf->a[j - 1] * buff_y->data[ny - j];
        printf("a[%d] * %g + ", j - 1, buff_y->data[ny - j]);
        // printf("a[%d] = %g\n", j, sys->tf->a[j]);
        // printf("y[%d] = %g\n", buff_y->size + 1 - j, buff_y->data[buff_y->size - j]);
    }

    y = (ac_x - ac_y) / sys->tf->a[0];
    printf(") = y[%d]*a[0] = %g\n", ny - 1, ac_x - ac_y);
    buffer_push(buff_y, y);
    printf("y[n] = %g\n", y);

    return y;
}
