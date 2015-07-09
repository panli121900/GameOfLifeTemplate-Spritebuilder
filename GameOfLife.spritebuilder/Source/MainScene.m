//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@implementation MainScene{
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
}

-(id)init{
    self = [super init];
    
    if (self){
        _timer = [[CCTimer alloc] init];
    }
    return (self);
}

-(void)play{
    
    //schedule step to run every .5 second
    [self schedule:@selector(step) interval:0.5f];
}

-(void)pause{
    
    //stop the scheduled update
    [self unschedule:@selector(step)];
    

    }

-(void)step{
    
    //evolve step and display label
    [_grid evolveStep];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    
}

@end
