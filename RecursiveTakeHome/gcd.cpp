// Christian Suleiman 
// Take Home Test 2 
// Recursive GCD with Euclid's Algortihm 

#include <iostream>
using namespace std;

//our gcd function assumes that a >= b and a, b > 0
int gcd(int a, int b) {

	if (b == 0) {
		return a;
	}
	else {
		gcd(b, a % b);
	}
}

int main() {
	cout << gcd(25, 10);
	return 0;
}