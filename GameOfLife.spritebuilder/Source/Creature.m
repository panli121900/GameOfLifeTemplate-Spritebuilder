//
//  Creature.m
//  GameOfLife
//
//  Created by apple on 7/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype)initCreature{
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

- (void) setIsAlive:(BOOL)newState{
    // when we create a property in .h file, an instance variable with leading underscore is automatically created
    _isAlive = newState;
    
    //visible is a property of CCNode from which CCSprite inherits
    self.visible = newState; 
}
@end
