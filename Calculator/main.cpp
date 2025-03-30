/**
 * @file main.cpp
 * @author Emanuel S Araldi
 * @brief Receives a string from the user and returns a double, made for testing
 * @version 0.1
 * @date 2025-03-29
 *
 * @copyright Copyright (c) 2025
 *
 */

#include <iostream>

#include "calculator.hpp"
#include "tester.hpp"

int main()
{
    Tester tester;
    Calculator calculator;

    tester.set_func(&Calculator::evaluate);
    tester.set_obj(calculator);
    tester.run();

    return 0;
}
