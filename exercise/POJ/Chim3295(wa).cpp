#include<iostream>
#include<vector>
#include<string>
#include<cstdio>
#include<string.h>
#include<map>
#include<set>
#include<list>
#include<queue>
#include<math.h>
#include<algorithm>
#include<cstdlib>
#include<stack>
using namespace std;

map<int,int> inv;

void init(){
	inv['p'] = 'z';inv['z'] = 'p';
	inv['q'] = 'x';inv['x'] = 'q';
	inv['r'] = 'c';inv['c'] = 'r';
	inv['s'] = 'v';inv['v'] = 's';
	inv['t'] = 'b';inv['b'] = 't';
	inv['1'] = '0';inv['0'] = '1';
}
char K(char w,char x){
	if(w == '1') return x;
	if(x == '1') return w;
	if(w == '0' || x == '0') return '0';
	if(x == inv[w]) return '0';
	if(x == w) return w;
	if(x != w && x != inv[w]) return 'e'; 	
}
char A(char w,char x){
	if(w == '0') return x;
	if(x == '0') return w;
	if(w == '1' || x == '1') return '1';
	if(x == w) return w;
	if(x == inv[w]) return '1';
	if(x != w && x != inv[w]) return 'e'; 
}
char N(char w){
	return inv[w];
}
char C(char w,char x){
	if(w == x) return '1';
	if(x == inv[w]) return x;
	if(w == '1') return x;
	if(w == '0') return '1';
	if(x == '1') return '1';
	if(x == '0') return inv[w];
	if(x != w && x != inv[w]) return 'e'; 	
}
char E(char w,char x){
	if(w == x) return '1';
	if(x == inv[w]) return '0';
	if(x != w && x != inv[w]) return 'e'; 
}
int main(){
	string s;
	init();
	while(cin >> s){
		if(s == "0") break;
		stack<char> stk;
		int flag = 0;
		for(int i = s.size()-1;i >=0;i-- ){
			if(s[i] == 'p' || s[i] == 'q' || s[i] == 'r' || s[i] == 's' || s[i] == 't')
				stk.push(s[i]);
			else{
				if(s[i] == 'N'){
					char m = stk.top();
					stk.pop();
					m = N(m);
					if(m == 'e') {flag = 1;break;}
					stk.push(m);
				}
				else{
					char m1 = stk.top();stk.pop();
					char m2 = stk.top();stk.pop();
					char m;
					if(s[i] == 'A') m = A(m2,m1);
					if(s[i] == 'K') m = K(m2,m1);
					if(s[i] == 'C') m = C(m1,m2);
					if(s[i] == 'E') m = E(m2,m1);
					if(m == 'e') {flag = 1;break;}
					stk.push(m);
				}
			}
		}
		if(flag) cout << "not" << endl;
		else if(stk.top() == '1') cout << "tautology" << endl;
		else cout << "not" << endl;

	}
	return 0;
}
