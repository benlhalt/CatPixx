//
//  GLShader.h
//  CatPixx
//
//  Created by Ben Halterman on 4/26/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLShader : NSObject {
    GLenum type;
    GLchar *shaderString;
}

@property (readonly) GLuint shaderID;

- (id)initWithFile:(NSString *)shaderFileName forShaderType:(GLenum)shaderType;

@end
