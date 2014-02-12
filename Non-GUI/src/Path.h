/**
 * @class   Path
 * @version 1.0
 * @file    Path.h
 * @author  Alex Cummaudo
 * @date    16 Oct 2013
 * @brief   Implements Path
 */

#ifndef __SwinAdventure__Path__
#define __SwinAdventure__Path__

// Include parent class
#include "GameObj.h"

// Forward declare classes used
class Player;
class Location;

class Path : public GameObj
{
public:
            Path    (vector<string> ids, string name, string desc, Location *destination, bool bidirectional);
    
    void    move    (Player *p);
private:
    Location    *_destination;
    bool        _bidirectional;
};

#endif /* defined(__SwinAdventure__Path__) */
