//
//  Grid.m
//  GameOfLife
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
  
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void) onEnter{
    [super onEnter];
    [self setupGrid];
    self.userInteractionEnabled = YES;
}

- (void) setupGrid{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;

    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_ROWS; i++){
        
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++){
            
            //creat creature
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
                        
            x+=_cellWidth;
        }
        
        y+=_cellHeight;
    }
}


-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
    //get location
    CGPoint touchLocation = [touch locationInNode:self];
    
    //?
    Creature *creature = [self creatureForPosition:touchLocation];

    //invert its state
    creature.isAlive = !creature.isAlive;
    
}

- (Creature *) creatureForPosition:(CGPoint)touchPosition{
    //get the row and column that was touched, return the Creature inside the corresponding cell
    int column = touchPosition.x / _cellWidth;
    int row = touchPosition.y / _cellHeight;
    return _gridArray[row][column];

}

- (void) evolveStep{
    
    [self countNeighbors];
    [self updateCreatures];
    _generation ++;
    
}

- (void) countNeighbors{
    
    //loop through the rows, _gridArray contains other arrays
    for (int i = 0; i < [_gridArray count]; i++){
        
        //loop thorugh the columns
        for (int j = 0; j < [_gridArray[i] count]; j++){
            
            //access the current creature (create another reference to it?)
            Creature *creature = _gridArray[i][j];
            creature.livingNeighbors = 0;
            
            //loop through the three rows
            for (int x = i-1; x <= i+1; x++){
                
                //loop through the three columns
                for (int y = j-1; y <= j+1; y++){
                    
                    //check whether this is a valid point
                    BOOL isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    if (!((x == i) && (y==j)) && isIndexValid){
                        
                        //create another reference to neighbor? tried _grid[x][y], doesn't work
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive){
                            creature.livingNeighbors ++;
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
    
}

-(BOOL) isIndexValidForX:(int)x andY:(int)y{
    BOOL isIndexValid = YES;
    if (x <0 || y<0 || x>= GRID_ROWS ||y>= GRID_COLUMNS){
        isIndexValid = NO;
    }
    return isIndexValid;
}

-(void)updateCreatures{
    
    //loop through rows
    for (int i =0; i < [_gridArray count]; i++){
        
        //loop through columns
        for (int j =0; j< [_gridArray count]; j++){
            
            //create another reference to current creature
            Creature *creature = _gridArray[i][j];
            
            //check if there is 3 neighbors
            if (creature.livingNeighbors == 3){
                creature.isAlive = YES;
            }
            else if (creature.livingNeighbors == 2){
                //do nothing
            }
            else{
                creature.isAlive = NO;
            }
        }
    }
    
}

@end
