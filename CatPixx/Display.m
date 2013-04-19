//
//  Display.m
//  CatPixx
//
//  Created by Ben Halterman on 4/18/13.
//  Copyright (c) 2013 Ben Halterman. All rights reserved.
//

#import "Display.h"

@implementation Display

@synthesize displayID = _displayID;
@synthesize displayPort = _displayPort;
@synthesize name = _name;

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
        
        // Get the service port for the display
        _displayPort = CGDisplayIOServicePort(displayID);
        
        
        CFTypeRef typeCode;
        //http://stackoverflow.com/questions/1236498/how-to-get-the-display-name-with-the-display-id-in-mac-os-x
        // Ask IOKit for the VRAM size property
        typeCode = IORegistryEntryCreateCFProperty(displayPorts[i],
                                                   CFSTR(kIOFBMemorySizeKey),
                                                   kCFAllocatorDefault,
                                                   kNilOptions);
        
        // Ensure we have valid data from IOKit
        if(typeCode && CFGetTypeID(typeCode) == CFNumberGetTypeID())
        {
            // If so, convert the CFNumber into a plain unsigned long
            CFNumberGetValue(typeCode, kCFNumberSInt32Type, vsArray[i]);
            if(typeCode)
                CFRelease(typeCode);
        }

    }
    return self;
}

@end
