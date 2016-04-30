#include <iostream>
#include <cstring>
#define NUMDIGITS 1024
#define DEFAULTBASE 2
using namespace std;


struct BigNumber
{
    int* digits;
    int base;
    mutable int n;

    BigNumber(int x, int b = DEFAULTBASE)
    {
        n = 1;
        digits = new int[NUMDIGITS];
        base = b;
        int k = 0;
        while (k<NUMDIGITS)
        {
            digits[k] = x%b;
            x/=b;
            if (digits[k])
                n = k+1;
            k++;
        }
    }

    BigNumber(const BigNumber &c)
    {
        digits = new int[NUMDIGITS];
        memcpy(this->digits,c.digits,NUMDIGITS*sizeof(int));
        this->n = c.n;
        this->base = c.base;
    }

    void operator= (const BigNumber &c)
    {
        digits = new int[NUMDIGITS];
        memcpy(this->digits,c.digits,NUMDIGITS*sizeof(int));
        this->n = c.n;
        this->base = c.base;
    }

    BigNumber operator+ (const BigNumber &X)
    {
        BigNumber ret(0);
        int i, t=0;
        for (i=0;i<NUMDIGITS;i++)
        {
            ret.digits[i] = digits[i]+X.digits[i]+t;
            t = ret.digits[i]/base;
            ret.digits[i] %= base;
            if (ret.digits[i])
                ret.n = i+1;
        }
        //cout << n;
        return ret;
    }

    BigNumber operator- (const BigNumber &X)
    {
        BigNumber ret(0);
        int i, t=0;
        for (i=0;i<NUMDIGITS;i++)
        {
            ret.digits[i] = digits[i]-X.digits[i]-t;
            if (ret.digits[i]<0)
                t = 1, ret.digits[i] += base;
            else
                t = 0;

            if (ret.digits[i])
                ret.n = i+1;
        }
        return ret;
    }

    BigNumber lowerHalf() const
    {
        BigNumber ret(0);
        for (int i=0;i<n/2;i++)
            ret.digits[i] = digits[i];
        ret.n = n/2;
        return ret;
    }

    BigNumber upperHalf() const
    {
        BigNumber ret(0);
        for (int i=0;i<n/2;i++)
            ret.digits[i] = digits[i+n/2];
        ret.n = n/2;
        return ret;
    }

    BigNumber operator << (int x) const
    {
        BigNumber ret(0);
        int i;
        for (i=NUMDIGITS-1;i>=x;i--)
            ret.digits[i] = digits[i-x];
        for (i=0;i<x;i++)
            ret.digits[i] = 0;
        ret.n=n+x;
        return ret;
    }

    void operator >>= (int x)
    {
        for (int i=0;i<NUMDIGITS-x;i++)
            digits[i] = digits[i+x];
        n-=x;

    }

    bool operator <= (BigNumber &X)
    {
        for (int i=0;i<max(X.n,n);i++)
            if (digits[i] > X.digits[i])
                return false;
        return true;
    }

    int closestGreaterPowerOfTwo(int x)
    {
        int i;
        for (i=1;i<x;i*=2);
        return i;
    }

    BigNumber operator * (BigNumber X)
    {
        X.n = closestGreaterPowerOfTwo(X.n);
        n = closestGreaterPowerOfTwo(n);
        X.n = max(X.n,n);
        n = max(X.n,n);

        /*cout << "(";
        display();
        cout << ",";
        X.display();
        cout << ")\n";
        */

        if (n==1)
        {
            BigNumber ret(0);
            int i, t=0;
            for (i=0;i<NUMDIGITS;i++)
            {
                ret.digits[i] = digits[0]*X.digits[i]+t;
                t = ret.digits[i]/base;
                ret.digits[i] %= base;
                if (ret.digits[i])
                    ret.n = i+1;
            }
            return ret;
        }
        else if (X.n == 1)
        {
            BigNumber ret(0);
            int i, t=0;
            for (i=0;i<NUMDIGITS;i++)
            {
                ret.digits[i] = digits[i]*X.digits[0]+t;
                t = ret.digits[i]/base;
                ret.digits[i] %= base;
                if (ret.digits[i])
                    ret.n = i+1;
            }
            return ret;
        }

        BigNumber xs = upperHalf(),
            xd = lowerHalf(),
            ys = X.upperHalf(),
            yd = X.lowerHalf(),
            p1(0), p2(0);

        if (xd <= xs)
            p1 = xs - xd;
        else
            p1 = xd - xs;

        //cout << "p1:"; p1.display(); cout << "!";

        if (yd <= ys)
            p2 = ys - yd;
        else
            p2 = yd - ys;

        //cout << "p2:"; p2.display(); cout << "!";

        BigNumber z0 = xd * yd,
        z1 = (xs + xd)*(ys + yd),
        z2 = xs * ys;

        return (z2<<n) + ((z1-z2-z0) << (n/2)) + z0;
    }

    void display() const
    {
        for (int i=n-1;i>=0;i--)
            cout << digits[i];
        //cout << "\n";
    }

    void displayAll()
    {
        for (int i=NUMDIGITS-1;i>=0;i--)
            cout << digits[i];
        //cout << "\n";
    }

    ~BigNumber()
    {
        delete[] digits;
    }
};

int main()
{
    long long A, B;
    cin >> A >> B;
    BigNumber a(A), b(B);
    BigNumber c = a * b;
    c.display();
    return 0;
}
