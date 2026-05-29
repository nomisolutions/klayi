//
//  MoonlanderOryx.h
//  klayi
//
//  Created by Valentyn Patsera on 2026-05-28.
//

#ifndef MoonlanderOryx_h
#define MoonlanderOryx_h

#import "Keyboard.h"
#import "CNUSBDevice.h"
#import "ZSA.h"

@interface MoonlanderOryx : NSObject<Keyboard, CNUSBDeviceDelegate>
@property (strong, nonatomic) CNUSBDevice *device;
@end

#endif /* MoonlanderOryx_h */
