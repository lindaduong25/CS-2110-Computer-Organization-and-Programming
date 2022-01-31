#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

// TODO: Create any necessary structs

/*
* For example, for a Snake game, one could be:
*
* struct snake {
*   int heading;
*   int length;
*   int row;
*   int col;
* };
*
* Example of a struct to hold state machine data:
*
* struct state {
*   int currentState;
*   int nextState;
* };
*
*/

// panda struct
struct panda {
    int horizontal;
    int vertical;
};
// bambo struct
struct bamboo {
    int x;
    int y;
    int exists;
    u16 color;
};


#endif
