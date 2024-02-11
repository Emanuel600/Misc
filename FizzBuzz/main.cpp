#include <vector>
#include <iostream>

using namespace std;

class Solution
{
public:
    vector<string> fizzBuzz(int n) {
        vector<string> solution;
        // Error Check
        if(n <= 0) {
            solution.emplace_back("Error");
            return solution;
        }
        // Resize vector to know size
        solution.resize(n);
        for(int i = 1; i <= n; i++) {
            string sol = "";
            if(!(i % 3)) {
                // Divisible by 3
                sol += "Fizz";
            }
            if(!(i % 5)) {
                // Divisible by 3
                sol += "Buzz";
            }
            if(!sol.size()) {
                sol = to_string(i);
            }
            solution[i - 1] = sol;
        }
        return solution;
    }
};

int main(void)
{
    Solution Sol;
    vector<string> retval(100);

    printf("n = -3:\n");
    int n = -3;
    retval = Sol.fizzBuzz(n);
    for(string s : retval) {
        cout << s << endl;
    }

    printf("n = 1:\n");
    n = 5;
    retval = Sol.fizzBuzz(n);
    for(string s : retval) {
        cout << s << endl;
    }

    printf("n = 100:\n");
    n = 100;
    retval = Sol.fizzBuzz(n);
    for(string s : retval) {
        cout << s << endl;
    }
}
