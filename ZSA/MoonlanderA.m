//
//  MoonlanderA.m
//  klayi
//
//  Created by Valentyn Patsera on 2026-01-24.
//

#import "MoonlanderA.h"

@implementation MoonlanderA

@synthesize name;
@synthesize delegate;

- (instancetype)init: (id<KeyboardDelegate>) delegate {
    self = [super init];
    if (self) {
        self.name = @"Moonlander (A)";
        self.delegate = delegate;
        NSDictionary *ZSA_ID = @{
            @kIOHIDVendorIDKey: @(ZSA_VENDOR_ID),
            @kIOHIDProductIDKey: @(ZSA_PRODUCT_ID_REV_A),
            @kIOHIDPrimaryUsagePageKey: @(ZSA_USER_PAGE)
        };
        self.device = [[CNUSBDevice alloc] initWithMatchingDictionary:ZSA_ID delegate:self];
        
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
    uint8_t buffer[4];
    [data getBytes:&buffer length:4];
    if (buffer[0] != ZSA_ACTIVE_LAYER_MSG) return;
    if (buffer[1] == ZSA_ACTIVE_LAYER_PUSH) {
        NSInteger index = (NSInteger)buffer[2];
        NSData *indexData = [NSData dataWithBytes:&index length:sizeof(index)];
        [self.delegate keyboard:self didChangeLayer:indexData];
    }
}

- (void)send:(NSData *)data {
    uint8_t buffer[32] = {0};
    buffer[0] = ZSA_ACTIVE_LAYER_MSG;

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
