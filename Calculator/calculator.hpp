/**
 * @file calculator.hpp
 * @author Emanuel S Araldi
 * @brief Header for calculator object
 * @version 0.1
 * @date 2025-03-29
 *
 * @copyright Copyright (c) 2025
 *
 */
#ifndef CALCULATOR_HPP
#define CALCULATOR_HPP
#include <vector>

using namespace std;


class Calculator
{
    vector<char> operator_stack;
    vector<double> number_stack;
public:
    double evaluate(string Input);
    void   calculate();
    int    operator_priority(char op);
};
#endif
