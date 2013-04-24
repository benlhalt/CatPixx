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
    
    // Get the list of active displays
    NSArray *screens = [NSScreen screens];
    NSMutableArray *displays = [NSMutableArray arrayWithCapacity:[screens count]];
    
    // Create Displays and append to array
    for(NSScreen *screen in screens) {
        [displays addObject:[[Display alloc] initWithNSScreen:screen]];
    }
    
    return displays;
}

- (id)initWithNSScreen:(NSScreen*)screen {
    self = [super init];
    if (self) {
        _screen = screen;
        _displayID = (CGDirectDisplayID)[[screen deviceDescription] valueForKey:@"NSSCreenNumber"];
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
