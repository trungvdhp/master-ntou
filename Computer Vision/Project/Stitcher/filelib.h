/*
 * A function to list all contents of a given directory
 * author: Danny Battison
 * modified by: Justin
 * contact: gabehabe@hotmail.com
 */
#include "stdio.h"
#include "dirent.h"
#include "vector"
#include "string"
using namespace std;

// Justin modified void listdir to return vector string
vector<string> listdir (const char *path)
{
	// first off, we need to create a pointer to a directory
	// remember, it's good practice to initialize a pointer to NULL!
	DIR *pdir = NULL;
	// "." will refer to the current directory
	pdir = opendir (path);
	struct dirent *pent = NULL;
	// declare a vector of string to store list file name;
	vector<string> result;
    // if pdir wasn't initialized correctly
	if (pdir == NULL)
	{
		// print an error message and exit the program
		printf ("\nERROR! Directory path '%s' could not be initialized correctly.\n", path);
		return result;
	}

	// while there is still something in the directory to list
	while (pent = readdir (pdir))
	{
		 // if pent has not been initialized correctly
		if (pent == NULL)
		{ 
			// print an error message, and exit the program
			printf ("\nERROR! Directory '%s' could not be initialized correctly", path);
			return result;
		}
		// otherwise, it was initialized correctly and if it's different '.' and '..'let's store it into vector
		if (strcmp(pent->d_name, ".") != 0 && strcmp(pent->d_name, "..") != 0)
		{
			int k = strlen(path);
			string t="";
			if (path[k-1] != '/') t = "/";
			result.push_back(string(path) + t + string(pent->d_name));
		}
	}

	// finally, let's close the directory and return result;
	closedir (pdir);
	return result;
}