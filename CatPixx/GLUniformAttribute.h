//
//  OpenGLUniformAttribute.h
//  CatPixx
//
//  Created by Ben Halterman on 5/7/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLProgram;

@interface GLUniformAttribute : NSObject

@property (strong, readonly) NSString *name;
@property (readonly) GLint location;
@property (strong) id value;
@property (weak) GLProgram *program;

- (id)initWithName:(NSString *)name andValue:(id)value inGLProgram:(GLProgram *)program;

- (void)updateToScreen;

@end
