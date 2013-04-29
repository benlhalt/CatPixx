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

- (id)initWithView:(StimulusView *)view {
    self = [super init];
    if (self) {
        _view = view;
        _programID = glCreateProgram();
    }
    return self;
}

- (void)attachShader:(GLShader *)shader {
    glAttachShader(_programID, shader.shaderID);
}

- (void)linkProgram {
    glLinkProgram(_programID);
}

@end
