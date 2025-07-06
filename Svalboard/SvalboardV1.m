//
//  SvalboardV1.m
//  Klayi
//
//  Created by Valentyn Patsera on 2025-06-08.
//  Copyright © 2025 Nomi Solutions. All rights reserved.
//

#import "SvalboardV1.h"

@implementation SvalboardV1

@synthesize name;
@synthesize delegate;

- (instancetype)init: (id<KeyboardDelegate>) delegate {
    self = [super init];
    if (self) {
        self.name = @"Svalboard";
        self.delegate = delegate;
        NSDictionary *QMK_ID = @{
            @kIOHIDVendorIDKey: @(QMK_VENDOR_ID),
            @kIOHIDProductIDKey: @(QMK_PRODUCT_ID),
            @kIOHIDPrimaryUsagePageKey: @(QMK_USER_PAGE)
        };
        self.device = [[CNUSBDevice alloc] initWithMatchingDictionary:QMK_ID delegate:self];
    }
    return self;
}

- (void)usbDeviceDidConnect:(CNUSBDevice *)device {
    [self.delegate keyboardDidConnect:self];
}

- (void)usbDeviceDidDisconnect:(CNUSBDevice *)device {
    [self.delegate keyboardDidDisconnect:self];
}

- (void)usbDevice:(CNUSBDevice *)device didReceiveData:(NSData *)data {
    uint8_t buffer[2];
    [data getBytes:&buffer length:2];
    if (buffer[0] != QMK_SVAL_ACTIVE_LAYER_MSG) return;
    NSInteger index = (NSInteger)buffer[1];
    NSData *indexData = [NSData dataWithBytes:&index length:sizeof(index)];
    [self.delegate keyboard:self didChangeLayer:indexData];
}

- (void)send:(NSData *)data {
    uint8_t buffer[32] = {0};
    buffer[0] = QMK_SVAL_ACTIVE_LAYER_MSG;

    NSUInteger copyLength = MIN(data.length, 31);
    [data getBytes:&buffer[1] length:copyLength];

    NSData *packet = [NSData dataWithBytes:buffer length:32];
    
    [self.device send:packet];
}

- (void)stop {
    [self.device stop];
}

- (void)start {
    [self.device start];
}

@end

