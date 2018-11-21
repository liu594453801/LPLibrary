//
//  KeyChainTool.m
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/5/30.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "KeyChainTool.h"
#import "PublicClass.h"
#import "DeviceTool.h"
#import "NSString+Tool.h"

@implementation KeyChainTool

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

#pragma mark 写入
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

#pragma mark 读取
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

#pragma mark 删除
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

//获取设备唯一标识
+ (NSString*)getOnlyDeviceUUID {
    //从keychain中读取设备唯一标识
    NSMutableDictionary *readDeviceUUID = (NSMutableDictionary *)[KeyChainTool load:KEY_DEVICE_UUID];
    NSString *deviceUUIDStr = [readDeviceUUID objectForKey:KEY_DEVICE_UUID];
    //如果发现获取为空则存储keychain后再返回
    if (![PublicClass CheckInputISNullBOOL:deviceUUIDStr]) {
        NSMutableDictionary *userNamePasswordKVPairs = [NSMutableDictionary dictionary];
        [userNamePasswordKVPairs setObject:[[DeviceTool shared] getDeviceUUIDString] forKey:KEY_DEVICE_UUID];
        [KeyChainTool save:KEY_DEVICE_UUID data:userNamePasswordKVPairs];
        
        //从keychain中读取设备唯一标识
        NSMutableDictionary *readDeviceUUID = (NSMutableDictionary *)[KeyChainTool load:KEY_DEVICE_UUID];
        deviceUUIDStr = [readDeviceUUID objectForKey:KEY_DEVICE_UUID];
    }
    return [NSString getSafeStrWithStr:deviceUUIDStr showNull:@""];
}

@end
