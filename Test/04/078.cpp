#include <iostream>
#include <vector>
#include <queue>
#include <set>
using namespace std;

int main()
{
    int n,m;
    int cost;
    int v;
    // Read number of electric wires
    cin>>n;
    // Number of vertex is n+1
    n++;
    // Wire length
    int L[n][n];
    // Check if vertex is visited
    bool visited[n];
    // Priority queue
    priority_queue< pair<int, int> > q;
    // Set V stores non-visited vertices
    set<int> V;
    // Iterator it for visiting vertices in set V
    set<int>::iterator it;
    // Temporary for getting top value in priority queue
    pair<int, int> tmp;
    
    // Read cost matrix
    for(int i=0; i<n; ++i)
    {
    	for(int j=0; j<n; ++j)
    	{
	       cin>>L[i][j];
   		}
    }
    
    // Initialize V={0,1,2,..,n-1}
    for(int i=0; i<n; ++i)
    {
    	V.insert(i);
    }
    // Initialize cost
    cost = 0;
    // Vertex #0 is visited => erase it out set V, and check it is visited
    V.erase(0);
    visited[0]=true;
    
    // Initialize: push cost between vertex #0 and vertices (inside V) in queue
    // Minus is before cost, because of that we need get min at top of queue
	// but queue is ordered by descending
	for (it=V.begin(); it!=V.end(); ++it)
        q.push(make_pair(-L[0][*it], *it));
    
	while(!q.empty())
    {
    	// Get top value in queue
       	tmp = q.top();
       	// Pop it out queue
       	q.pop();
       	// Get vertex id
       	v = tmp.second;
       	
       	// If vertex #v is not yet visited
       	if(!visited[v])
       	{
       		// Check vertex #v is visited
			visited[v] = true;
			// Update minimum cost
			cost += tmp.first;
			//cout<<tmp.first<<" "<<tmp.second<<endl;
			// Erase vertex #v out set V
			V.erase(v);
			// Check if set V is empty then break out while loop
			if(V.empty()) break;
			// Push cost between vertex #v and vertices (inside V) in queue
          	for (it=V.begin(); it!=V.end(); ++it)
        		q.push(make_pair(-L[v][*it], *it));
       }
    }
    // Print final minimum cost
    cout<<-cost;
    return 0;
}

