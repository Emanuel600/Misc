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
    buff.size = size - 1;
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
    for(int i = 0; i < buffer->size; i++) {
        buffer->data[i] = buffer->data[i + 1];
    }
    buffer->data[buffer->size] = data;
}

double lti_rtf(LTI_System* sys, double x)
{
    double ac_x = 0;
    double ac_y = 0;

    buffer* buff_x = &sys->x;
    buffer* buff_y = &sys->y;

    double y = 0;

    buffer_push(buff_x, x);

    for(int j = 0; j < buff_x->size + 1; j++) {
        ac_x += sys->tf->b[j] * buff_x->data[buff_x->size - j];
    }
    for(int j = 1; j < buff_y->size + 1; j++) {
        ac_y += sys->tf->a[j] * buff_y->data[buff_y->size + 1 - j];
    }

    y = (ac_x - ac_y) / sys->tf->a[0];
    buffer_push(buff_y, y);

    return y;
}
