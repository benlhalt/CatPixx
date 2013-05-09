//
//  OpenGLUniformAttribute.m
//  CatPixx
//
//  Created by Ben Halterman on 5/7/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "GLUniformAttribute.h"
#import "GLProgram.h"
#import "OpenGL/gl3.h"
#import "OpenGL/gl3ext.h"

@implementation GLUniformAttribute

@synthesize name = _name;
@synthesize location = _location;
@synthesize value = _value;
@synthesize program = _program;

- (id)initWithName:(NSString *)name andValue:(id)value inGLProgram:(GLProgram *)program {
    self = [super init];
    if (self) {
        _name = name;
        _value = value;
        _program = program;
        _location = -1;
    }
    return self;
}

- (GLint)location {
    if (_location == -1) {
        _location = [_program getUniformLocationForName:self.name];
    }
    return _location;
}

- (void)updateToScreen {
    // view's OpenGL context must be current and locked!
    if ([_value isKindOfClass:[NSNumber class]]) {
        glUniform1f(self.location, [self.value floatValue]);
    } else if ([_value isKindOfClass:[NSArray class]]) {
        if ([_value count] == 2) {
            glUniform2f(self.location, [self.value[0] floatValue], [self.value[1] floatValue]);
        } else if ([_value count] == 3) {
            glUniform3f(self.location, [self.value[0] floatValue], [self.value[1] floatValue], [self.value[2] floatValue]);
        } else if ([_value count] == 4) {
            glUniform4f(self.location, [self.value[0] floatValue], [self.value[1] floatValue], [self.value[2] floatValue], [self.value[3] floatValue]);
        } else {
            NSLog(@"invalid value for %@", _name);
        }
    } else {
        NSLog(@"invalid value for %@", _name);
    }
}

@end
