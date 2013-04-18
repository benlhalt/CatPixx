//
//  Display.m
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "Display.h"

@implementation Display

- (id)initWithID:(CGDirectDisplayID)DisplayID {
    self = [super init];
    if (self) {
        self.DisplayID = DisplayID;
    }
    return self;
}

@end
