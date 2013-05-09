//
//  DriftingGrating.m
//  CatPixx
//
//  Created by Ben Halterman on 5/6/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "DriftingGrating.h"
#import "GLUniformAttribute.h"
#import "GLProgram.h"
#import "StimulusView.h"

@implementation DriftingGrating

@synthesize contrast = _contrast;
@synthesize center = _center;
@synthesize radius = _radius;
@synthesize orientation = _orientation;
@synthesize temporalFrequency = _temporalFrequency;
@synthesize spatialFrequency = _spatialFrequency;

- (id)initWithProgram:(GLProgram *)program {
    self = [super initWithProgram:program];
    if (self) {
        [self setUniformFloatKey:@"contrast" withValue:1.0];
        [self setUniformVectorKey:@"center" withValue:@[@0.4, @0.2]];
        [self setUniformFloatKey:@"radius" withValue:1.0];
        [self setUniformFloatKey:@"orientation" withValue:M_PI_4];
        [self setUniformFloatKey:@"spatialFrequency" withValue:20.0];
        [self setUniformFloatKey:@"phase" withValue:0.0];
        _temporalFrequency = @1.0;
        _tZero = 0;
        _startTimeisSet = NO;
    }
    return self;
}

- (void)updateScreenForTime:(const CVTimeStamp *)outputTimeStamp {
    if (!_startTimeisSet) {
        _startTimeisSet = YES;
        _tZero = outputTimeStamp->videoTime;
    }
    float timeSinceStart = ((double)(outputTimeStamp->videoTime - _tZero))/((double)(outputTimeStamp->videoTimeScale));
    float phase = 2.0 * M_PI * fmod(timeSinceStart, 1.0/[_temporalFrequency floatValue]) * [_temporalFrequency floatValue];
    ((GLUniformAttribute *)(self.uniformAttributes[@"phase"])).value = [NSNumber numberWithFloat:phase];
    [super updateScreenForTime:outputTimeStamp];
}

@end
