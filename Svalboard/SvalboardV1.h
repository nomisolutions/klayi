//
//  SvalboardV1.h
//  Klayi
//
//  Created by Valentyn Patsera on 2025-06-08.
//  Copyright © 2025 Nomi Solutions. All rights reserved.
//

#ifndef SvalboardV1_h
#define SvalboardV1_h
#import "Keyboard.h"
#import "CNUSBDevice.h"
#import "QMK.h"

@interface SvalboardV1 : NSObject<Keyboard, CNUSBDeviceDelegate>
@property (strong, nonatomic) CNUSBDevice *device;
@end

#endif /* SvalboardV1_h */
