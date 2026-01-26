//
//  CommunicationProtocolV2.m
//  Klayi
//
//  Created by Valentyn Patsera on 2025-06-08.
//  Copyright © 2025 Nomi Solutions. All rights reserved.
//

#import "SvalboardV2.h"

@implementation SvalboardV2

@synthesize name;
@synthesize delegate;

- (instancetype)init: (id<KeyboardDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.name = @"Svalboard";
        NSDictionary *QMK_ID = @{
            @kIOHIDVendorIDKey: @(QMK_VENDOR_ID),
            @kIOHIDProductIDKey: @(QMK_PRODUCT_ID),
            @kIOHIDPrimaryUsagePageKey: @(QMK_USER_PAGE)
        };
        self.device = [[CNUSBDevice alloc] initWithMatchingDictionary:QMK_ID delegate:self];
        self.keepAlive = [[CNKeepAlive alloc] initWithInterval:15 delegate:self];
    }
    return self;
}

- (void)handler {
    uint8_t refreshBuffer[1] = {QMK_SVAL_REFRESH_TIMER_CMD};
    NSData *refreshPacket = [[NSData alloc] initWithBytes:refreshBuffer length:1];
    [self send:refreshPacket];
}

- (void)usbDeviceDidConnect:(CNUSBDevice *)device {
    [self.keepAlive start];
    [self.delegate keyboardDidConnect:self];
}

- (void)usbDeviceDidDisconnect:(CNUSBDevice *)device {
    [self.keepAlive stop];
    [self.delegate keyboardDidDisconnect:self];
}

- (void)usbDevice:(CNUSBDevice *)device didReceiveData:(NSData *)data {
    uint8_t buffer[3];
    [data getBytes:&buffer length:3];
    if (buffer[0] != QMK_SVAL_ACTIVE_LAYER_MSG) return;
    if (buffer[1] == QMK_SVAL_ACTIVE_LAYER_PUSH) {
        NSInteger index = (NSInteger)buffer[2];
        NSData *indexData = [NSData dataWithBytes:&index length:sizeof(index)];
        [self.delegate keyboard:self didChangeLayer:indexData];
    } else if (buffer[1] == QMK_SVAL_REFRESH_TIMER_CMD) {
        if ([self.delegate respondsToSelector:@selector(keyboardDidRefreshConnection:)]) {
            [self.delegate keyboardDidRefreshConnection:self];
        }
        
    } else {
        if ([self.delegate respondsToSelector:@selector(keyboard:didReceiveData:)]) {
            [self.delegate keyboard:self didReceiveData:data];
        }
        
    }
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
