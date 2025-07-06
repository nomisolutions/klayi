//
//  Keyboard.h
//  Klayi
//
//  Created by Valentyn Patsera on 2025-06-08.
//  Copyright © 2025 Nomi Solutions. All rights reserved.
//

#ifndef Keyboard_h
#define Keyboard_h

#import <Foundation/Foundation.h>
#import "KeyboardDelegate.h"

@protocol Keyboard
@property (assign, nonatomic) NSString *name;
@property (weak, nonatomic) id<KeyboardDelegate> delegate;
- (instancetype)init: (id<KeyboardDelegate>) delegate;
- (void)send:(NSData *)data;
- (void)start;
- (void)stop;
@end

#endif /* Keyboard_h */
