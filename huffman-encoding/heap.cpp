#include <iostream>
#include <cstdlib>
using namespace std;

const long DIM = 100;

struct node
{
    int data;
    char key;

    node(char k, int d) : key(k), data(d) {}
    node() : key(-1), data(-1) {}
    void display()
    {
        cout << "(" << key << "," << data << ")\n";
    }
    bool operator <(node& B)
    {
        return data < B.data;
    }
    bool operator >(node& B)
    {
        return data > B.data;
    }
    bool operator >=(node& B)
    {
        return data >= B.data;
    }
};

struct BinaryTree
{
    node data;
    BinaryTree* left, *right;
    long N;

    BinaryTree(node val)
    {
        this->data = val;
        left = 0;
        right = 0;
    }

    ~BinaryTree()
    {
        if (left)
            delete left;
        if (right)
            delete right;
    }

    void display()
    {
        display(this);
    }

    static void display(BinaryTree *h, int level = 0)
    {
        for (int i=0;i<level;i++)
            cout << "\t";
        if (h==0)
        {
            cout << "-\n";
            return;
        }
        h->data.display();

        display(h->left,level+1);
        display(h->right,level+1);

    }
};


struct Heap
{
    long N = 0, NB = 0;
    BinaryTree* A[DIM];

    void eroare(bool cond, char* s)
    {
        if (cond)
        {
            cout << s;
            exit(0);
        }
    }

    void retro (long i)
    {
        long parinte, fiu;
        BinaryTree* aux;

        parinte = i;
        fiu = 2*i;
        while (fiu <= N)
        {
            if (fiu+1 <= N && A[fiu]->data > A[fiu+1]->data)
                fiu = fiu+1;
            if (A[fiu]->data < A[parinte]->data)
            {
                aux = A[parinte];
                A[parinte] = A[fiu];
                A[fiu] = aux;
                parinte = fiu;
                fiu = fiu*2;
            }
            else
                fiu = N+1;
        }
    }

    void build_heap()
    {
        for (int i=N/2;i>=1;i--)
            retro(i);
    }

    void insert(BinaryTree* x)
    {
        long parinte, fiu;
        BinaryTree* aux;
        A[N+1] = x;
        N++;
        fiu = N;
        parinte = N/2;
        while (parinte >= 1)
        {
            if (A[parinte] == 0 || A[parinte]->data > A[fiu]->data)
            {
                aux = A[parinte];
                A[parinte] = A[fiu];
                A[fiu] =aux;
                fiu = parinte;
                parinte /=2;
            }
            else parinte = 0;
        }
    }

    BinaryTree* remove()
    {
        BinaryTree* ret_val;
        long parinte, fiu;
        BinaryTree* aux;
        if (N==0)
            throw 5;
        ret_val = A[1];
        //cout << "~! " << A[1]->data << "\n";
        A[1] = A[N];
        N--;
        parinte = 1;
        fiu = 2;
        while (fiu <= N)
        {
            if (fiu+1<=N && A[fiu]->data > A[fiu+1]->data)
                fiu++;
            if (A[fiu]->data < A[parinte]->data)
            {
                aux = A[fiu];
                A[fiu] = A[parinte];
                A[parinte] = aux;
                parinte = fiu;
                fiu *=2;
            }
            else
                fiu = N+1;
        }
        return ret_val;
    }

    void display()
    {
        for (int i=1;i<=N;i++)
        if (A[i])
            A[i]->display();
        else
            cout << "~";
    }

    void displayRoot()
    {
        cout << "[[";
        for (int i=1;i<=N;i++)
            if (A[i])
                A[i]->data.display();
        cout << "]]";
    }
};
