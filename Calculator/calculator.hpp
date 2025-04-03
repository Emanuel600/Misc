/**
 * @file calculator.hpp
 * @author Emanuel S Araldi
 * @brief Header for calculator object
 * @version 1.1
 * @date 2025-03-29
 *
 * @copyright Copyright (c) 2025
 *
 */
#ifndef CALCULATOR_HPP
#define CALCULATOR_HPP
#include <vector>

using namespace std;

/**
 * @brief                   Class for solving simple equation strings
 *
 * @param operator_stack    char vector containg all operators to be solved
 * @param number_stack      double vector containg all numbers to be solved
 */
class Calculator
{
    vector<char> operator_stack;
    vector<double> number_stack;
public:
    /**
     * @brief           Evaluates a string
     *
     * @param Input     String containing equation to be evaluated. Ex: "3+(4*2)^50"
     * @return double   Result of evaluated equation
     */
    double evaluate(string Input);
    /**
     * @brief           Takes two numbers from *number_stack* and the operator from
     *                  *operator_stack* and pushes result to back of *number_stack*
     * @return void     Pushes directly to *number_stack*
     */
    void   calculate();
    /**
     * @brief           Returns priority of an operator
     *
     * @param op        Operator, Ex: '+'
     * @return int      Priority of operator
     */
    int    operator_priority(char op);
};
#endif
