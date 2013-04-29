//
//  GLShader.m
//  CatPixx
//
//  Created by Ben Halterman on 4/26/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "GLShader.h"

@implementation GLShader

@synthesize shaderID = _shaderID;

- (id)initWithFile:(NSString *)shaderFileName forShaderType:(GLenum)shaderType {
    self = [super init];
    type = shaderType;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:shaderFileName ofType:nil];
    if (filePath) {
        NSStringEncoding *encoding = nil;
        NSError *error = nil;
        NSString *shaderNSString = [NSString stringWithContentsOfFile:filePath usedEncoding:encoding error:&error]; // doesn't seem to use "encoding" pointer
        if (error) {
            NSLog(@"GLShader initWithFile: Error reading shader file: %@", error);
        } else {
            NSUInteger length = [shaderNSString length];
            char *sourceString = calloc(length+1, sizeof(char));
            BOOL success = [shaderNSString getCString:sourceString maxLength:length+1 encoding:[NSString defaultCStringEncoding]];
            if (success) {
                shaderString = (GLchar *)sourceString;
                _shaderID = glCreateShader(type);
                glShaderSource(_shaderID, 1, (const GLchar * const *)&shaderString, NULL);
                glCompileShader(_shaderID);
            }
            free(sourceString);
        }
    }
    return self;
}

@end