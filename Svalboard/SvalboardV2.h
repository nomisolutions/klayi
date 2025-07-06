//
//  SvalboardV2.h
//  Klayi
//
//  Created by Valentyn Patsera on 2025-06-08.
//  Copyright © 2025 Nomi Solutions. All rights reserved.
//

#ifndef SvalboardV2_h
#define SvalboardV2_h
#import "Keyboard.h"
#import "CNKeepAlive.h"
#import "CNUSBDevice.h"
#import "QMK.h"

@interface SvalboardV2 : NSObject<Keyboard, CNUSBDeviceDelegate, CNKeepAliveDelegate>
@property (strong, nonatomic) CNKeepAlive *keepAlive;
@property (strong, nonatomic) CNUSBDevice *device;
@end


#endif /* SvalboardV2_h */
