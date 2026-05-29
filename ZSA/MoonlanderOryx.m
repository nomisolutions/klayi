//
//  MoonlanderOryx.m
//  klayi
//
//  Created by Valentyn Patsera on 2026-05-28.
//

#import "MoonlanderOryx.h"

static NSString * const MoonlanderOryxErrorDomain = @"MoonlanderOryxErrorDomain";

@interface MoonlanderOryx ()
@property (assign, nonatomic) BOOL paired;
@end

@implementation MoonlanderOryx

@synthesize name;
@synthesize delegate;

+ (NSString *)displayName {
    return @"Moonlander (Oryx)";
}

- (instancetype)init: (id<KeyboardDelegate>) delegate {
    self = [super init];
    if (self) {
        self.name = @"Moonlander (Oryx)";
        self.delegate = delegate;
        NSDictionary *ZSA_ID = @{
            @kIOHIDVendorIDKey: @(ZSA_VENDOR_ID),
            @kIOHIDProductIDKey: @(ZSA_PRODUCT_ID_REV_A),
            @kIOHIDPrimaryUsagePageKey: @(ZSA_USER_PAGE),
            @kIOHIDPrimaryUsageKey: @(ZSA_ORYX_USAGE_ID)
        };
        self.device = [[CNUSBDevice alloc] initWithMatchingDictionary:ZSA_ID delegate:self];
        
    }
    return self;
}

- (void)usbDeviceDidConnect:(CNUSBDevice *)device {
    self.paired = NO;
    [self pairWithKeyboard];
}

- (void)usbDeviceDidDisconnect:(CNUSBDevice *)device {
    self.paired = NO;
    [self.delegate keyboardDidDisconnect:self];
}

- (void)usbDevice:(CNUSBDevice *)device didReceiveData:(NSData *)data {
    uint8_t buffer[32] = {0};
    [data getBytes:&buffer length:MIN(data.length, sizeof(buffer))];
    
    if (buffer[0] == ZSA_ORYX_EVT_PAIRING_SUCCESS) {
        [self handlePairingSuccess];
        return;
    }
    
    if (buffer[0] == ZSA_ORYX_EVT_ERROR) {
        [self notifyErrorWithCode:buffer[1]];
        return;
    }
    
    if (buffer[0] == ZSA_ORYX_EVT_LAYER) {
        [self handleLayerEvent:buffer];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didReceiveData:)]) {
        [self.delegate keyboard:self didReceiveData:data];
    }
}

- (void)handleLayerEvent:(uint8_t *)buffer {
    if (buffer[2] != ZSA_ORYX_STOP_BIT) {
        return;
    }

    NSInteger index = (NSInteger)buffer[1];
    NSData *indexData = [NSData dataWithBytes:&index length:sizeof(index)];
    [self.delegate keyboard:self didChangeLayer:indexData];
}

- (void)handlePairingSuccess {
    if (self.paired) {
        return;
    }
    
    self.paired = YES;
    [self.delegate keyboardDidConnect:self];
}

- (void)send:(NSData *)data {
    uint8_t buffer[32] = {0};
    
    NSUInteger copyLength = MIN(data.length, sizeof(buffer));
    [data getBytes:&buffer length:copyLength];
    
    NSData *packet = [NSData dataWithBytes:buffer length:sizeof(buffer)];
    
    [self.device send:packet];
}

- (void)stop {
    self.paired = NO;
    [self.device stop];
}

- (void)start {
    [self.device start];
}

- (void)pairWithKeyboard {
    uint8_t buffer[32] = {0};
    buffer[0] = ZSA_ORYX_CMD_PAIRING_INIT;
    
    NSData *packet = [NSData dataWithBytes:buffer length:sizeof(buffer)];
    [self.device send:packet];
}

- (void)notifyErrorWithCode:(uint8_t)code {
    if (![self.delegate respondsToSelector:@selector(keyboard:didError:)]) {
        return;
    }
    
    NSError *error = [NSError errorWithDomain:MoonlanderOryxErrorDomain
                                         code:code
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Oryx protocol error: 0x%02X", code]}];
    [self.delegate keyboard:self didError:error];
}

@end
