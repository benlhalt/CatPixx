//
//  Stimulus.m
//  CatPixx
//
//  Created by Ben Halterman on 5/7/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "Stimulus.h"
#import "GLUniformAttribute.h"
#import "GLProgram.h"

@implementation Stimulus

@synthesize uniformAttributes = _uniformAttributes;
@synthesize vectorAttributes = _vectorAttributes;
@synthesize program = _program;

- (id)initWithProgram:(GLProgram *)program {
    self = [super init];
    if (self) {
        _program = program;
        _uniformAttributes = [[NSMutableDictionary alloc] init];
        _vectorAttributes = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setUniformKey:(NSString *)key withValue:(id)value {
    GLUniformAttribute *attribute = [self.uniformAttributes objectForKey:key];
    if (attribute) {
        attribute.value = value;
    } else {
        attribute = [[GLUniformAttribute alloc] initWithName:key andValue:value inGLProgram:self.program];
        [self.uniformAttributes setObject:attribute forKey:key];
    }
}

- (void)updateScreenForTime:(const CVTimeStamp *)outputTime {
    for (id attribute in [_uniformAttributes objectEnumerator]) {
        [attribute updateToScreen];
    }
}

@end
