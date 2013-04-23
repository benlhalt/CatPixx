//
//  Display.m
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "Display.h"
#import "IOKit/graphics/IOGraphicsLib.h"

@implementation Display

@synthesize displayID = _displayID;
@synthesize screen = _screen;

+ (NSArray*)getCurrentDisplayList {
    
    CGError error = CGDisplayNoErr;
    CGDirectDisplayID *displayIDs = NULL;
    uint32_t displayCount = 0;
    
    // How many active displays do we have?
    error = CGGetActiveDisplayList(0, NULL, &displayCount);
    
    // Allocate enough memory to hold all the display IDs we have
    displayIDs = calloc((size_t)displayCount, sizeof(CGDirectDisplayID));
    
    // Get the list of active displays
    error = CGGetActiveDisplayList(displayCount, displayIDs, &displayCount);
    
    NSMutableArray *displays = [NSMutableArray arrayWithCapacity:(NSUInteger)displayCount];
    
    // Create Displays and append to array
    for(int i = 0; i < displayCount; i++) {
        [displays addObject:[[Display alloc] initWithID:displayIDs[i]]];
    }
    
    return displays;
}

- (id)initWithID:(CGDirectDisplayID)displayID {
    self = [super init];
    if (self) {
        _displayID = displayID;
    }
    return self;
}

- (NSString *)name {
    
    NSString *screenName = nil;
    
    NSDictionary *localizedNames = [self.displayInfo objectForKey:[NSString stringWithUTF8String:kDisplayProductName]];
    
    if ([localizedNames count] > 0) {
    	screenName = [localizedNames objectForKey:[[localizedNames allKeys] objectAtIndex:0]];
    }
    
    return screenName;
}

- (NSScreen *)screen {
    return _screen;
}

- (io_service_t)displayPort {
    return CGDisplayIOServicePort(_displayID);
}

- (NSDictionary *)displayInfo {
    return (NSDictionary *)CFBridgingRelease(IODisplayCreateInfoDictionary(self.displayPort, kIODisplayOnlyPreferredName));
}

@end
