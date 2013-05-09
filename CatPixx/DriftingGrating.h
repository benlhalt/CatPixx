//
//  DriftingGrating.h
//  CatPixx
//
//  Created by Ben Halterman on 5/6/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "Stimulus.h"

@interface DriftingGrating : Stimulus {
    int64_t _tZero;
    BOOL _startTimeisSet;
}

@property (strong) NSNumber *contrast;
@property (strong) NSArray *center;
@property (strong) NSNumber *radius;
@property (strong) NSNumber *orientation;
@property (strong) NSNumber *temporalFrequency;
@property (strong) NSNumber *spatialFrequency;

- (id)initWithProgram:(GLProgram *)program;

- (void)updateScreenForTime:(const CVTimeStamp *)outputTimeStamp;

@end
