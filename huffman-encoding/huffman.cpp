#include <iostream>
#include <string>
#include <map>
#include <utility>
#include "heap.cpp"

long n, i, y;
char x;
string s;
using namespace std;

typedef map<char,pair<int,string> > KType;

void generateStrings(BinaryTree* root, string s, KType& m)
{
    if (root == 0)
        return;
    if (root->data.key!=' ')
        m[root->data.key].second = s;
    else
    {
        generateStrings(root->left,s+"0",m);
        generateStrings(root->right,s+"1",m);
    }
}

int main()
{
    KType K;

    cin >> s;
    int l = s.size();
    for (i=0;i<l;i++)
    {
        if (K.count(s[i]) != 0)
            K[s[i]].first++;
        else
            K[s[i]]=make_pair(1,"");
    }

    //cin >> n;
    n = K.size();
    Heap* H = new Heap();
    for (map<char,pair<int,string> >::iterator it=K.begin();it != K.end();it++)
    {
        H->insert(new BinaryTree(node(it->first,it->second.first)));
    }
    while (n>1)
    {
        BinaryTree* min1, *min2, *newBinTree;
        min1 = H->remove();
        //cout << "min1: " << min1->data << "\n";
        min2 = H->remove();
        //cout << "min2: " << min2->data << "\n";
        newBinTree = new BinaryTree(node(' ',min1->data.data+min2->data.data));
        n-=2;
        newBinTree->left = min1;
        newBinTree->right = min2;
        H->insert(newBinTree);
        n++;
    }
    cout << "\n";
    H->A[1]->display();

    generateStrings(H->A[1],"",K);

    for (map<char,pair<int,string> >::iterator it=K.begin();it != K.end();it++)
    {
        cout << it->first << " " << it->second.second << "\n";
    }

    for (i=0;i<l;i++)
        cout << K[s[i]].second;
    cout << "\n";
    return 0;
}
