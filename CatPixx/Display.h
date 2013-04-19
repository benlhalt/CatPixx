//
//  Display.h
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Display : NSObject

@property (readonly) CGDirectDisplayID displayID;
@property (readonly) io_service_t displayPort;
@property (readonly) NSString name;

+ (NSArray*)getCurrentDisplayList;

- (id)initWithID:(CGDirectDisplayID)displayID;

@end
