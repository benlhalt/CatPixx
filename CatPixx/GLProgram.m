//
//  GLProgram.m
//  CatPixx
//
//  Created by Ben Halterman on 4/26/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "GLProgram.h"
#import "StimulusView.h"
#import "GLShader.h"

@implementation GLProgram

@synthesize view = _view;
@synthesize programID = _programID;
@synthesize isLinked = _isLinked;

- (id)initWithView:(StimulusView *)view {
    self = [super init];
    if (self) {
        _view = view;
        _programID = glCreateProgram();
        _isLinked = NO;
    }
    return self;
}

- (void)attachShader:(GLShader *)shader {
    [self.view.openGLContext makeCurrentContext];
    glAttachShader(_programID, shader.shaderID);
}

- (void)linkProgram {
    if (!self.isLinked) {
        [self.view lockAndMakeCurrent];
        glLinkProgram(_programID);
        [self.view unlock];
        _isLinked = YES;
    }
}

- (GLint)getUniformLocationForName:(NSString *)name {
    GLint location = -1;
    if (self.isLinked) {
        [self.view lockAndMakeCurrent];
        location =  glGetUniformLocation(self.programID, [name cStringUsingEncoding:NSASCIIStringEncoding]);
        [self.view unlock];
    } else {
        NSLog(@"Attempted to get location for '%@', but GLProgram is not linked!", name);
    }
    return location;
}

@end
