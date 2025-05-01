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
    vector<string> Input = {"3+5",          // 1
                           "2.132+1.434",   // 2
                           "5-2",           // 3
                           "2-5",           // 4
                           "10.241-5.13",   // 5
                           "1.2412-5.4213", // 6
                           "3*4",           // 7
                           "4*3",           // 8
                           "1.34*5",        // 9
                           "7/2",           // 10
                           "2/7",           // 11
                           "3^2",           // 12
                           "0.4^5",         // 13
                           "4^0.3",         // 14
                           "0.8^0.2",       // 15
                           "(2+4)/2",       // 16
                           "7*(1+3)",       // 17
                           "3*(5-2)/30"     // 18
                   };
    vector<double> Expected_Output = {3.0 + 5.0,    // 1
                           2.132 + 1.434,           // 2
                           5.0 - 2.0,               // 3
                           2.0 - 5.0,               // 4
                           10.241 - 5.13,           // 5
                           1.2412 - 5.4213,         // 6
                           3.0 * 4.0,               // 7
                           4.0 * 3.0,               // 8
                           1.34 * 5.0,              // 9
                           7.0 / 2.0,               // 10
                           2.0 / 7.0,               // 11
                           pow(3, 2),               // 12
                           pow(0.4, 5.0),           // 13
                           pow(4, 0.3),             // 14
                           pow(0.8, 0.2),           // 15
                           (2.0 + 4.0) / 2.0,       // 16
                           7.0 * (1.0 + 3.0),       // 17
                           3.0 * (5.0 - 2.0) / 30.0 // 18
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
