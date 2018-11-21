//
//  DeviceTool.h
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/4/23.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceTool : NSObject

+ (DeviceTool *)shared;

/**
 获取UUID(IDFV)
 
 @return 返回UUID，设备唯一标识码(3DCF9688-6946-4C30-8B27-377A7910DCB0)
 */
- (NSString *)getDeviceUUIDString;

/**
 获取mac 地址
 
 @return 返回mac 地址
 */
- (NSString *)getMacAddress;

/**
 获取手机名称
 
 @return 返回手机名称(xxx的iphone)
 */
- (NSString *)getIphoneName;

/**
 获取设备名称
 
 @return 返回设备名称(iPhone OS)
 */
- (NSString *)getDeviceName;

/**
 获取国际化区域名称
 
 @return 返回国际化区域名称(iphone)
 */
- (NSString *)getLocalizedModel;

/**
 获取设备系统版本号
 
 @return 返回系统版本号（eg:11.2.2）
 */
- (NSString *)getDeviceVersion;

/**
 获取设备型号
 
 @return 返回设备型号(iphone X)
 */
- (NSString *)getDeviceType;

/**
 获取应用版本号
 
 @return 返回应用版本号(1.11.0)
 */
- (NSString *)getAppVersion;

/**
 获取应用名称
 
 @return 返回应用名称(及时云)
 */
- (NSString *)getAppName;

/**
 获取应用的icon
 
 @return 返回应用icon
 */
- (UIImage *)getAppIcon;

/**
 获取应用启动页
 
 @return 返回应用启动页
 */
- (UIImage *)getAppLaunchImage;

/**
 获取设备物理尺寸
 
 @return 返回设备物理尺寸(375*667)
 */
- (CGSize)getDeviceSize;

/**
 获取设备分辨率
 
 @return 返回分辨率基数（基数*物理尺寸=分辨率）
 */
- (CGFloat)getDeviceScale;


/**
 获取设备运营商
 
 @return 返回设备运营商
 */
- (NSString *)getDeviceCarrierName;

/**
 获取设备电量
 
 @return 返回电量
 */
- (CGFloat)getDeviceElectricity;

/**
 获取精确的设备电量
 
 @return 返回电量
 */
- (CGFloat)getCurrentBatteryLevel;

/**
 获取设备当前使用语言
 
 @return 返回使用语言
 */
- (NSString *)getDeviceLanguage;

/**
 获取电池充电状态
 
 @return 返回充电状态(UnKnow：无法取得充电状态情况;Unplugged：不是充电状态;Charging：连接充电状态;Full：连接充满状态)
 */
- (NSString *)getBatteryState;

/**
 获取设备内存大小
 
 @return 返回内存大小
 */
- (long long)getTotalMemorySize;

/**
 获取当前设备可用内存
 
 @return 返回可用内存
 */
- (double)getAvailableMemory;

/**
 获取当前当前应用占用内存
 
 @return 返回占用内存
 */
- (double)getAppUsedMemory;

/**
 获取设备ip
 
 @param preferIPv4 是否是IPv4（YES:ipv4 NO:ipv6）
 @return 返回ip
 */
- (NSString *)getIPAddress:(BOOL)preferIPv4;

/**
 获取当前连接wifi名称
 
 @return 返回wifi名称
 */
- (NSString *)getWifiName;

/**
 调用系统短信提醒省
 */
-(void)playSystemSound;

/**
 *  调用系统相机
 */
- (BOOL)callCamera;

/**
 *  调用系统相册
 */
+ (void)callPhoto:(void(^)(BOOL status))isCan;

@end
