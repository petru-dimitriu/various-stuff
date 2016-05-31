/*
 * sudoku.cpp
 *
 */

#include <fstream>
#include <iostream>
using namespace std;
ifstream in("sudoku.in");
ofstream out("sudoku.out");

// Liniile, coloanele si subpatratele tabloului se numeroteaza cu 0 ... 8
// subpatratele sunt numerotate asa:
/*  - - - - - - -
 *  | 0 | 1 | 2 |
 *  - - - - - - -
 *  | 3 | 4 | 5 |
 *  - - - - - - -
 *  | 6 | 7 | 8 |
 *  - - - - - - -
 */

int t[9][9];			   // tabloul propriu-zis
bool patrat[9][10];		   // patrat[x][y] = 1, daca numarul y se afla in patratul x
bool linie[9][10];		   // linie[x][y] = 1, daca numarul y se afla pe linia x
bool coloana[9][10];	   // coloana[x][y] = 1, daca numarul y se afla pe coloana x
bool gata;				   // = 1 daca s-a gasit o solutie, deci nu are sens sa se mai caute

// functie recursiva de rezolvare
void rezolva(int x, int y)
{
	int i,j,urmx=0,urmy=0;
	/* caut, pentru inceput, casuta pe care o am de umplut
	 * dupa ce umplu casuta curenta
	 */
	for (i=x, j=y+1;i<9 && !urmx && !urmy;i++)
	{

		for (;j<9 && !urmx && !urmy;j++)
		{
			if (t[i][j] == 0)
			{
				urmx = i;
				urmy = j;
			}
		}
		j = 0;
	}

	// incerc, pe rand, toate variantele pentru casuta curenta
	for (i=1;i<=9 && !gata;i++)
	{
		if (linie[x][i] == 0  && // daca nu se afla pe linia x
			coloana[y][i] == 0  // si nu se afla pe coloana y
			&& patrat[(x/3) * 3 + y/3][i] == 0) // si nu se afla nici in patratul curent
		{
			// poate fi adaugat
			t[x][y] = i; // adaugam in tabel
			// marcam ca pe linia, coloana,si in patratul curent,
			// s-a pus deja numarul pe care l-am asezat, deci nu il mai putem pune dupa el
			linie[x][i] = 1;
			coloana[y][i] = 1;
			patrat[(x/3) * 3 + y/3][i] = 1;
			// si trecem mai departe la urmatoarul patratel de umplut
			if (urmx != 0 || urmy != 0) // asta daca mai exista un patratel gol
			{
				rezolva(urmx,urmy);
				// daca incercarea de a rezolva sudokuul cu numarul curent pe pozitia asta a esuat
				if (!gata)
				{
					// demarcam tot ce marcasem
					linie[x][i] = 0;
					coloana[y][i] = 0;
					patrat[(x/3) * 3 + y/3][i] = 0;
					t[x][y] =  0;
				}
			}
			else // daca nu mai exista niciun patratel gol inseamna ca am rezolvat sudokuul
			{
				gata = 1; // marchez ca am terminat; se vor incheia pe rand toate functiile
			}
		}
	}
}

void afiseaza()
{
	int i, j;
	for (i=0;i<9;i++)
	{
		for (j=0;j<9;j++)
			out << t[i][j] << " ";
		out << "\n";
	}
}

int main()
{
	int i, j, n, x, y, v;
	in >> n;
	for (i=1;i<=n;i++)
	{
		in >> x >> y >> v;
		x--; y--; // scad 1 pentru ca am numerotat intern lin si col de la 0
		t[x][y] = v; // introduc nr in tabel
		patrat[(x/3) * 3 + y/3][v] = 1; // marchez ca in subpatrat am numarul introdus
		linie[x][v] = 1; // marchez ca pe lin exista numarul tocmai introdus, deci nu trebuie reintrodus
		coloana[y][v] = 1; // marchez ca pe col exista numarul tocmai introdus
	}
	// Cautam primul patratel gol ca sa incepem algoritmul de acolo
	for (i=0;i<9 && !gata;i++)
	{
		for (j=0;j<9 && !gata;j++)
		{
			if (t[i][j] == 0)
			{
				// functia de rezolvare va seta variabila globala gata la 1,
				// ceea ce va duce automat la incheierea for-urilor
				rezolva(i,j);
				afiseaza();
			}
		}
		j = 0;
	}
	return 0;
}
