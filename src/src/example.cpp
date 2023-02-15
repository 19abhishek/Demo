#include "example.h"
using namespace std;

// #include "sha256.hh"
#include "sha512.hh"


#include <vector>
#include <string>

namespace example {
	long multiply(long a, long b) {
		return a * b;
	}
	// string sha256(string a) {
    // 	return sha256::calculateSHA256(a);
  	// }
	string sha512(string a) {
    	return sha512::calculateSHA512(a);
  	}
	string xorString(string a, string b) {
      size_t n = a.length(), m = b.length();
      size_t l = max(n, m);
      vector<int>A(l), B(l);
        
      for(size_t i = 0; i < n; i++) {
        A[i] = (int)a[i];
      }
      for(size_t i = n; i < l; i++) {
        A[i] = 0;
      }
      
      for(size_t i = 0; i < m; i++) {
        B[i] = (int)b[i];
      }
      for(size_t i = m; i < l; i++) {
        B[i] = 0;
      }

      vector<char>C(l);
      for(int i = 0; i < l; i++)
        C[i] = A[i] ^ B[i];
        
      string res(C.begin(), C.end());
      return res;
    }
}