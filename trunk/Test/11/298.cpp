#include<iostream>
#include<queue>
#define maxN 401
using namespace std;

bool a[maxN][maxN];

int main()
{
	// m: count 1 in a lake
	int m;
    int x,y;
    // row count and column count
	int r,c;
	// (dx, dy)=(0, 1)=>shift right one column
	// (dx, dy)=(0,-1)=>shift left one column
	// (dx, dy)=(1, 0)=>shift down one row
	// (dx, dy)=(-1,0)=>shift up one row
    int dx[]={0,0,1,-1};
    int dy[]={1,-1,0,0};
    
    queue< pair<int,int> > q;
    pair<int,int> p;
    
    cin>>r>>c;
    
    for(int i=0; i<r; ++i)
		for(int j=0; j<c; ++j)
			cin>>a[i][j];

    for(int i=0; i<r; ++i)
    {
		for(int j=0; j<c; ++j)
       	{
       		// a[i][j]=1 (or true)
        	if(a[i][j])
          	{
		  		m=0;
		  		// push point (i,j) in queue
		  		// point (i,j) is visited
             	q.push(make_pair(i,j));
             	a[i][j]=false;
             	
             	// while queue is not empty
             	while(!q.empty())
             	{
             		// point p is in lake and it is counted
             		// pop p out queue
             		m++;
                	p=q.front();
                	q.pop();
                	
                	// shift by 4 direction
                	for(int k=0; k<4; ++k)
                	{
                		// get new coordinate
                    	x=p.first+dx[k];
                    	y=p.second+dy[k];
                    	
                    	// push point (x,y) in queue if it is a neighbor of point (i,j)
            			// point (x,y) is visited
                    	if(a[x][y])
                    	{
                       		q.push(make_pair(x,y));
                       		a[x][y]=false;
                    	}
                	}
             	}
             	cout<<m<<endl;
        	}
		}
	}
	
    return 0;
}

