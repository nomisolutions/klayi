//
//  KeyboardDelegate.h
//  Klayi
//
//  Created by Valentyn Patsera on 2025-07-01.
//  Copyright © 2025 Nomi Solutions. All rights reserved.
//

#ifndef KeyboardDelegate_h
#define KeyboardDelegate_h

@protocol Keyboard;

@protocol KeyboardDelegate <NSObject>
- (void)keyboardDidConnect: (id<Keyboard>)keyboard;
- (void)keyboardDidDisconnect: (id<Keyboard>)keyboard;
- (void)keyboard: (id<Keyboard>)keyboard didChangeLayer: (NSData *)data;

@optional
- (void)keyboard: (id<Keyboard>)keyboard didError: (NSError *) error;
- (void)keyboardDidRefreshConnection: (id<Keyboard>)keyboard;
- (void)keyboard: (id<Keyboard>)keyboard didReceiveData: (NSData *)data;
@end

#endif /* KeyboardDelegate_h */
