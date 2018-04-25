//
//  PORLibrary.h
//  Portland Rose
//
//  Created by Hunter Ford on 25/04/2018.
//  Copyright © 2018 Useless Corporation. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface PORLibrary : NSObject

/**
 * Initializes a `PORLibrary` instance, running `callback`
 * when the library is ready for use.
 */
- (instancetype) initWithCompletionBlock: (void (^)(void)) callback;

@end
