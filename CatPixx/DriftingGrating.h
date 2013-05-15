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

@property float contrast;
@property NSPoint center;
@property float radius;
@property float orientation;
@property float temporalFrequency;
@property float spatialFrequency;

- (id)initWithProgram:(GLProgram *)program;

- (void)updateScreenForTime:(const CVTimeStamp *)outputTimeStamp;

@end
