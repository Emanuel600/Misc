/**
 * @file tester.hpp
 * @author Emanuel S Araldi
 * @brief Generic header for a tester class
 * @version 0.1
 * @date 2025-03-29
 *
 * @copyright Copyright (c) 2025
 *
 */
#ifndef TESTER_HPP
#define TESTER_HPP
#include <iostream>
#include <limits>
#include <vector>
#include <math.h>

#include "calculator.hpp"

using namespace std;
typedef double (Calculator::*test_func)(string); // pointer to the function that will be tested
typedef Calculator test_obj;


/**
 * @brief                       Class to test return values from a specified function
 *
 * @param Input                 Input vector to be tested
 *
 * @param Expected_Output       Vector with the expected returns for the function
 *
 * @param Program_Output        Vector with the program's outputs for Input vector
 *
 * @param f                     Function to be tested
 *
 * @param obj                   Object containing the function to be tested
 */
class Tester
{
    vector<string> Input = {"3+5",
                           "2.132+1.434",
                           "5-2",
                           "2-5",
                           "10.241-5.13",
                           "1.2412-5.4213",
                           "3*4",
                           "4*3",
                           "1.34*5",
                           "7/2",
                           "2/7",
                           "3^2",
                           "0.4^5",
                           "4^0.3",
                           "0.8^0.2",
                           "(2+4)/2",
                           "7*(1+3)",
                           "3*(5-2)/30"
                   };
    vector<double> Expected_Output = {3.0 + 5.0,
                           2.132 + 1.434,
                           5.0 - 2.0,
                           2.0 - 5.0,
                           10.241 - 5.13,
                           1.2412 - 5.4213,
                           3.0 * 4.0,
                           4.0 * 3.0,
                           1.34 * 5.0,
                           7.0 / 2.0,
                           2.0 / 7.0,
                           pow(3, 2),
                           pow(0.4, 5),
                           pow(4, 0.3),
                           pow(0.8, 0.2),
                           (2.0 + 4.0) / 2.0,
                           7.0 * (1.0 + 3.0),
                           3.0 * (5.0 - 2.0) / 30.0
                   };
    vector<double> Program_Output =
            vector<double>(Expected_Output.size(),
                    numeric_limits<double>::quiet_NaN());

    test_func f;
    test_obj  obj;
public:
    void run();     /// Runs function 'f' and compares vector (Outputs to stdout)

    inline void set_func(test_func tf) {    /// Sets function to be tested
        f = tf;
    };

    inline void set_obj(test_obj o) {    /// Sets function to be tested
        obj = o;
    };
};
#endif
