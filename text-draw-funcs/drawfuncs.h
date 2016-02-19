#pragma once
#include <cmath>
#include <windows.h>

void gotoxy(short x, short y);
void clreol(void );
inline double sign(double x);
void point( int x,  int y);
void line( int x1,  int y1,  int x2,  int y2);
void triangle( int x1,  int y1, int x2,  int y2, int x3,  int y3);
