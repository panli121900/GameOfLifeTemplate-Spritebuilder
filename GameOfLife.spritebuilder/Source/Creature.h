//
//  Creature.h
//  GameOfLife
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

//store whether creature is living
@property (nonatomic, assign) BOOL isAlive;

//store the number of neighbors
@property (nonatomic, assign) NSInteger livingNeighbors;

-(id) initCreature;

@end
