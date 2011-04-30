//
//  AmigoDelegate.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoCallbackDelegate.h"


@implementation AmigoCallbackDelegate

@synthesize delegate = delegate_;
@synthesize selectorNames = selectorNames_;

- (id) init {
    self = [super init];
    
    if (self ){
        self.delegate = nil;
        self.selectorNames = [NSSet set];
    }
    
    return self;
}

- (id) initWithDelegate: (id)del andSelectorNameArray: (NSArray *)array{
    self = [self init];
    if (self) {
        self.delegate = del;
        self.selectorNames = [NSSet setWithArray:array];
        
    }
    
    return self;
}

- (BOOL) performCallback: (NSString *)selectorName {
    
    
    BOOL isValidCallback = [self.selectorNames containsObject:selectorName];
    SEL callback = NSSelectorFromString(selectorName);
    
    if (isValidCallback) {
        
        if ([self.delegate respondsToSelector:callback]) {
            [self.delegate performSelector:callback];
            return YES;
        }
        else {
            NSLog(@"%@ does not respond to this callback %@", self.delegate, callback);
            return NO;
        }
    }
    
    else {
        NSLog(@"not allowed to perform this callback %@ on this delegate", self.delegate);
        return NO;
    }
    
}

- (void) dealloc {
    [delegate_ release];
    [selectorNames_ release];
    [super dealloc];
}

@end
