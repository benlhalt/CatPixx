//
//  Stimulus.h
//  CatPixx
//
//  Created by Ben Halterman on 5/7/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLProgram;

@interface Stimulus : NSObject

@property (strong, readonly) NSMutableDictionary *uniformAttributes;
@property (strong, readonly) NSMutableDictionary *vectorAttributes;
@property (weak) GLProgram *program;

- (id)initWithProgram:(GLProgram *)program;

- (void)setUniformFloatKey:(NSString *)key withValue:(float)value;

- (void)setUniformVectorKey:(NSString *)key withValue:(NSArray *)value;

- (void)updateScreenForTime:(const CVTimeStamp *)outputTime;

@end
