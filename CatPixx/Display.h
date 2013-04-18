//
//  Display.h
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Display : NSObject

@property CGDirectDisplayID DisplayID;

- (id)initWithID:(CGDirectDisplayID)DisplayID;

@end
