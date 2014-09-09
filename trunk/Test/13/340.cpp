#include<iostream>
#include<string>
using namespace std;

void replace_all(string& subject, const string search,
                          const string replace) 
{
    size_t pos = 0;
    size_t sl=search.length();
    // The position of the first character of the first match.
	// If no matches were found, the function returns string::npos.
    while((pos=subject.find(search, pos))!=string::npos) 
	{
		 // Replaces the portion of the string that begins at character pos 
		 // and spans len characters (or the part of the string in the range 
		 // between [i1,i2)) by new contents:
         subject.replace(pos,sl,replace);
         // Update new position
         pos += replace.length();
    }
}
int main()
{
	string subject,search,replace;
	getline(std::cin,subject);
	getline(std::cin,search);
	getline(std::cin,replace);
	replace_all(subject,search,replace);
	cout<<subject;
	return 0;
}
