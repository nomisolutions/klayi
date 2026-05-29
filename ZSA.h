//
//  ZSA.h
//  klayi
//
//  Created by Valentyn Patsera on 2026-01-24.
//

#ifndef ZSA_h
#define ZSA_h

#define ZSA_VENDOR_ID 0x3297
#define ZSA_PRODUCT_ID_REV_A 0x1969
#define ZSA_PRODUCT_ID_REV_B 0x1972
#define ZSA_USER_PAGE 0xFF60
#define ZSA_ORYX_USAGE_ID 0x61

#define ZSA_ACTIVE_LAYER_MSG 0xA5
#define ZSA_ACTIVE_LAYER_PUSH 0x01

#define ZSA_ORYX_CMD_PAIRING_INIT 0x01
#define ZSA_ORYX_CMD_DISCONNECT 0x03
#define ZSA_ORYX_EVT_PAIRING_SUCCESS 0x04
#define ZSA_ORYX_EVT_LAYER 0x05
#define ZSA_ORYX_EVT_ERROR 0xFF
#define ZSA_ORYX_STOP_BIT 0xFE

#endif /* ZSA_h */
