//
//  GLProgram.h
//  CatPixx
//
//  Created by Ben Halterman on 4/26/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StimulusView;
@class GLShader;

@interface GLProgram : NSObject

@property (weak) StimulusView *view;
@property (readonly) GLint programID;

- (id)initWithView:(StimulusView *)view;

- (void)attachShader:(GLShader *)shader;

- (void)linkProgram;

@end
