/**
 * @file calculator.cpp
 * @author Emanuel S Araldi
 * @brief
 * @version 0.1
 * @date 2025-03-29
 *
 * @copyright Copyright (c) 2025
 *
 */
#include <stack>
#include <math.h>
#include <iostream>
#include <algorithm>

#include "calculator.hpp"

using namespace std;

double Calculator::evaluate(string Input)
{
    cout << "\n[evaluate]: function called for [" << Input << "]\n" << endl;
    for(long long unsigned int i = 0; i < Input.length(); i++) {
        char ch = Input[i];
        cout << "[evaluate]: for loop on char [" << ch << "]\n" << endl;
        if(ch == ' ') {
            continue;
        } else if(ch == '(') { // Open Brackets
            this->operator_stack.push_back(ch);
        } else if((isdigit(ch) || ch == '.' || ch == ',')) { // Convert number string to double
            string temp = "";
            while((isdigit(ch) || ch == '.' || ch == ',') && i < Input.length()) {
                temp += ch;
                i    += 1;
                ch    = Input[i];
            }
            i--;
            this->number_stack.push_back(stod(temp));
            cout << "[evaluate]: converted string [" << temp;
            cout << "] to double [" << this->number_stack.back() << ']' << endl;
        } else if(ch == ')') { // Solve Brackets
            cout << "[evaluate]: brackets solver called\n" << endl;
            while(!(this->operator_stack.empty()) && this->operator_stack.back() != '(') {
                this->calculate();
            }
            this->operator_stack.pop_back(); // Remove '('
        }
        // Current Token is an Operator
        else {
            while(!this->operator_stack.empty() &&
                    this->operator_priority(this->operator_stack.back()) >= this->operator_priority(ch)) {
                this->calculate();
                cout << "[evaluate]: solver called for operator [" << this->operator_stack.back() << "]" << endl;
            }
            this->operator_stack.push_back(ch);
            cout << "[evaluate]: operator [" << this->operator_stack.back() << "] pushed\n" << endl;
        }
    }
    // Solve Remaining Operators
    while(!this->operator_stack.empty()) {
        this->calculate();
    }
    // Back of Number Stack contains result
    cout << "[evaluate]: Result for [" << Input << "] = [" << this->number_stack.back() << "]\n\n" << endl;
    return this->number_stack.back();
}

int Calculator::operator_priority(char ch)
{
    cout << "\n[operator priority]: called for [" << ch << "]\n" << endl;
    if(ch == '+' || ch == '-') {
        return 1;
    }
    if(ch == '*' || ch == '/') {
        return 2;
    }
    if(ch == '^') {
        return 3;
    }
    return -5;
}

void Calculator::calculate()
{
    double b = this->number_stack.back();
    this->number_stack.pop_back();

    double a = this->number_stack.back();
    this->number_stack.pop_back();

    char op = this->operator_stack.back();
    this->operator_stack.pop_back();

    cout << "\n[calculate]: called for [" << a << op << b << "]\n" << endl;

    switch(op) {
    case '+':
        this->number_stack.push_back(a + b);
        break;
    case '-':
        this->number_stack.push_back(a - b);
        break;
    case '*':
        this->number_stack.push_back(a * b);
        break;
    case '/':
        this->number_stack.push_back(a / b);
        break;
    case '^':
        this->number_stack.push_back(pow(a, b));
        break;
    default:
        break;
    }
    cout << "[calculate] returned [" << this->number_stack.back() << "]\n" << endl;
    return;
}
