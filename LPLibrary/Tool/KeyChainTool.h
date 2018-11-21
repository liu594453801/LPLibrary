//
//  KeyChainTool.h
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/5/30.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

NSString * const KEY_DEVICE_UUID = @"com.berchina.app.deviceuuid";

@interface KeyChainTool : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

// save username and password to keychain
+ (void)save:(NSString *)service data:(id)data;

// load username and password from keychain
+ (id)load:(NSString *)service;

// delete username and password from keychain
+ (void)delete:(NSString *)serviece;

//获取设备唯一标识
+ (NSString*)getOnlyDeviceUUID;


@end
