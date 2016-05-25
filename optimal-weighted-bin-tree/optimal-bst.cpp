#include <iostream>
#include "heap.cpp"

using namespace std;
int main()
{
    long n, i, x;
    cin >> n;
    Heap* H = new Heap();
    for (i=0;i<n;i++)
    {
        cin >> x;
        H->insert(new BinaryTree(x));
    }
    H->display();

    while (n>1)
    {
        BinaryTree* min1, *min2, *newBinTree;
        min1 = H->remove();
        //cout << "min1: " << min1->data << "\n";
        min2 = H->remove();
        //cout << "min2: " << min2->data << "\n";
        newBinTree = new BinaryTree(min1->data+min2->data);
        n-=2;
        newBinTree->left = min1;
        newBinTree->right = min2;
        H->insert(newBinTree);
        n++;
    }
    cout << "\n";
    H->A[1]->display();

    return 0;
}
