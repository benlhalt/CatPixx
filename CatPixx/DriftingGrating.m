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
        [self setUniformKey:@"contrast" withValue:@1.0];
        [self setUniformKey:@"center" withValue:@[@0.0, @0.0]];
        [self setUniformKey:@"radius" withValue:@0.5];
        [self setUniformKey:@"orientation" withValue:@(0*M_PI)];
        [self setUniformKey:@"spatialFrequency" withValue:@20.0];
        [self setUniformKey:@"phase" withValue:@0.0];
        _temporalFrequency = 2.0;
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
    float phase = 2.0 * M_PI * fmod(timeSinceStart, 1.0/self.temporalFrequency) * self.temporalFrequency;
    ((GLUniformAttribute *)(self.uniformAttributes[@"phase"])).value = [NSNumber numberWithFloat:phase];
    [super updateScreenForTime:outputTimeStamp];
}

- (float)contrast {
    return _contrast;
}

- (void)setContrast:(float)contrast {
    _contrast = contrast;
    [self setUniformKey:@"contrast" withValue:@(contrast)];
}

- (NSPoint)center {
    return _center;
}

- (void)setCenter:(NSPoint)center {
    _center = center;
    [self setUniformKey:@"center" withValue:@[@(center.x), @(center.y)]];
}

- (float)radius {
    return _radius;
}

- (void)setRadius:(float)radius {
    _radius = radius;
    [self setUniformKey:@"radius" withValue:@(radius)];
}

- (float)orientation {
    return _orientation;
}

- (void)setOrientation:(float)orientation {
    _orientation = orientation;
    [self setUniformKey:@"orientation" withValue:@(orientation)];
}

- (float)temporalFrequency {
    return _temporalFrequency;
}

- (void)setTemporalFrequency:(float)temporalFrequency {
    _temporalFrequency = temporalFrequency;
}

- (float)spatialFrequency {
    return _spatialFrequency;
}

- (void)setSpatialFrequency:(float)spatialFrequency {
    _spatialFrequency = spatialFrequency;
    [self setUniformKey:@"spatialFrequency" withValue:@(spatialFrequency)];
}

@end
