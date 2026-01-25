//
//  MoonlanderA.h
//  klayi
//
//  Created by Valentyn Patsera on 2026-01-24.
//

#ifndef MoonlanderA_h
#define MoonlanderA_h
#import "Keyboard.h"
#import "CNUSBDevice.h"
#import "ZSA.h"

@interface MoonlanderA : NSObject<Keyboard, CNUSBDeviceDelegate>
@property (strong, nonatomic) CNUSBDevice *device;
@end

#endif /* MoonlanderA_h */
