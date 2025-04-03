/**
 * @file tester.cpp
 * @author Emanuel S Araldi
 * @brief Generic cpp file for a tester class
 * @version 0.1
 * @date 2025-03-29
 *
 * @copyright Copyright (c) 2025
 *
 */

#include <iostream>
#include "tester.hpp"

#include "macros.hpp"

void Tester::run()
{
    test_obj calc = this->obj;
    int i = 0;
    for(auto &element : (*this).Input) {
        DEBUG("Beggining Test #" << i + 1 << " for Input=[" << element << "]" << endl;)
        (*this).Program_Output[i] = calc.evaluate(element);
        i++;
    }

    i = 0;
    for(auto &element : (*this).Program_Output) {
        if(element == (*this).Expected_Output[i]) {
            cout << "Passed test #" << i + 1 << "!" << endl;
        } else {
            cout << "Failed test #" << i + 1 << "!" << endl;
        }
        i++;
    }
}
