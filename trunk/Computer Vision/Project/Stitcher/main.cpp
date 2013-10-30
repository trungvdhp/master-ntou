#include "main.h"

string getexepath()
{
	TCHAR result[MAX_PATH];
	GetCurrentDirectory(MAX_PATH, result);
	wstring arr_w(result);
	string arr_s(arr_w.begin(), arr_w.end());
	return arr_s;
}

int main( int argc, const char** argv )
{
	int n;
	char dir[255];
	vector<string> files;
	Stitcher stitcher = Stitcher::createDefault();
	
	while(1)
	{
		cout << "Input path of image list (0 = escape, 1 = default 'InputData\\2\\'):" << endl;
		cin >> dir;

		if (strcmp(dir, "1") == 0)
			strcpy(dir, "InputData\\2\\");
		else if (strcmp(dir, "0") == 0)
			break;

		files = listdir(dir);
		n = files.size();

		Mat pano;
		vector<Mat> imgs;

		for (int i = 0; i < n; i++)
		{
			imgs.push_back(imread(files[i]));
			cout << files[i] << endl;
		}

		Stitcher::Status status = stitcher.stitch(imgs, pano);

		if (status != Stitcher::OK)
		{
			cout << "Error stitching - Code: " <<int(status)<<endl;
			continue;
		}

		imshow("Stitched Image", pano);

		waitKey();
	}
	
	system("pause");
	return 0;
}


