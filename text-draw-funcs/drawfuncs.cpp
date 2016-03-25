/* Elementary functions for drawing in text mode (console) 	under Windows*/

#include "drawfuncs.h"

void gotoxy(short x, short y)
{
    HANDLE hConsoleOutput = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD dwCursorPosition;
    dwCursorPosition.X = x;
    dwCursorPosition.Y = y;
    SetConsoleCursorPosition(hConsoleOutput, dwCursorPosition);
}

void clreol(void )
{
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_SCREEN_BUFFER_INFO sInfo={0};
    GetConsoleScreenBufferInfo( hConsole , &sInfo);

    SHORT nDistance = sInfo.dwSize.X -
                      sInfo.dwCursorPosition.X ;

    DWORD dwNumberOfCharsWritten=0;
    FillConsoleOutputCharacter( hConsole,
                                ' ',
                                nDistance,
                                sInfo.dwCursorPosition,
                                &dwNumberOfCharsWritten);

    SetConsoleCursorPosition( hConsole,sInfo.dwCursorPosition);
}


inline double sign(double x)
{
    if (x==0)
        return 0;
    else if (x<0)
        return -1;
    return 1;
}

void point( int x,  int y)
{
    gotoxy(x,y);
    static const char c = 'x';
    WriteConsole(GetStdHandle(STD_OUTPUT_HANDLE),&c,1,NULL,NULL);
}

void line( int x1,  int y1,  int x2,  int y2)
{
    int x, y;
    double deltax = x2 - x1,
           deltay = y2 - y1,
           error = 0,
           deltaerr = fabs((deltay+0.0)/(deltax+0.0));
    y = y1;
    x = x1;
    do
    {
        point(x,y);
        error += deltaerr;
        while (error >= 0.5 && (y2 >= y1 && y<=y2 || y2 <= y1 && y>=y2 )  )
        {
            point(x,y);
            y += sign(y2-y1);
            error -= 1;
        }
        x += sign(x2-x1);
    } while (x!=x2);
}

void triangle( int x1,  int y1,
               int x2,  int y2,
               int x3,  int y3)
{
    line(x1,y1,x2,y2);
    line(x2,y2,x3,y3);
    line(x1,y1,x3,y3);
}
