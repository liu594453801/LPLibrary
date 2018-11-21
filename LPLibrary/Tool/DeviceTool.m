//
//  DeviceTool.m
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/4/23.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "DeviceTool.h"

//获取设备型号需导入
#import "sys/utsname.h"
//获取运营商需导入
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//获取电池电量
#import <objc/runtime.h>
//获取设备ip
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

//获取当前设备可用内存及所占内存
#import<sys/sysctl.h>
#import<mach/mach.h>

//获取当前wifi名称
#import <SystemConfiguration/CaptiveNetwork.h>

//获取设备短息提示声
#import <AudioToolbox/AudioToolbox.h>

//相册相机访问
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation DeviceTool

static DeviceTool *sharedManager = nil;
+ (DeviceTool *)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[DeviceTool alloc]init];
        
    });
    return sharedManager;
}

#pragma mark =========== 获取UUID(IDFV) ===========
/**
 获取UUID

 @return UUID
 */
- (NSString *)getDeviceUUIDString{
    NSString *identifierString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return identifierString;
}

#pragma mark =========== 获取mac地址 ===========
/**
 获取mac 地址
 
 @return 返回mac 地址
 */
- (NSString *)getMacAddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = (char*)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

#pragma mark =========== 获取手机名称 ===========
/**
 获取手机名称
 
 @return 返回手机名称(xxx的iphone)
 */
- (NSString *)getIphoneName{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}

#pragma mark =========== 获取设备名称 ===========
/**
 获取设备名称
 
 @return 返回设备名称(iPhone OS)
 */
- (NSString *)getDeviceName{
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}

#pragma mark =========== 获取设备系统版本号 ===========
/**
 获取设备系统版本号
 
 @return 返回系统版本号（eg:11.2.2）
 */
- (NSString *)getDeviceVersion{
    NSString* deviceVersion = [[UIDevice currentDevice] systemVersion];
    return deviceVersion;
}

#pragma mark =========== 获取国际化区域名称 ===========
/**
 获取国际化区域名称
 
 @return 返回国际化区域名称(iphone)
 */
- (NSString *)getLocalizedModel{
    NSString* localizedModel = [[UIDevice currentDevice] localizedModel];
    return localizedModel;
}

#pragma mark =========== 获取设备型号 ===========
/**
 获取设备型号
 
 @return 返回设备型号(iphone X)
 */
- (NSString *)getDeviceType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"iPod1,1"])      return@"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return@"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return@"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return@"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return@"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPad1,1"])      return@"iPad 1G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return@"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return@"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return@"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return@"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return@"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return@"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return@"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return@"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return@"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return@"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return@"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return@"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return@"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return@"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return@"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,3"])      return@"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])      return@"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return@"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return@"iPad Mini 2G";
    if ([deviceString isEqualToString:@"iPad4,7"])      return@"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return@"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return@"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return@"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return@"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return@"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return@"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return@"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return@"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return@"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return@"iPad Pro 12.9";
    
    return deviceString;
}

#pragma mark =========== 获取应用版本号 ===========
/**
 获取应用版本号
 
 @return 返回应用版本号(1.11.0)
 */
- (NSString *)getAppVersion{
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    return appVersion;
}

#pragma mark =========== 获取应用名称 ===========
/**
 获取应用名称
 
 @return 返回应用名称
 */
- (NSString *)getAppName{
    NSString *appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    return appName;
}

#pragma mark =========== 获取应用的icon ===========
/**
 获取应用的icon
 
 @return 返回应用icon
 */
- (UIImage *)getAppIcon{
    NSString *icon = [[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    return [UIImage imageNamed:icon?icon:@""];
}

#pragma mark =========== 获取应用启动页 ===========
/**
 获取应用启动页
 
 @return 返回应用启动页
 */
- (UIImage *)getAppLaunchImage{
    UIImage *lauchImage = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    } else {
        viewOrientation = @"Portrait";
    }
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}

#pragma mark =========== 获取设备物理尺寸 ===========
/**
 获取设备物理尺寸
 
 @return 返回设备物理尺寸(375*667)
 */
- (CGSize)getDeviceSize{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    return size;
}

#pragma mark =========== 获取设备分辨率 ===========
/**
 获取设备分辨率
 
 @return 返回分辨率基数（基数*物理尺寸=分辨率）
 */
- (CGFloat)getDeviceScale{
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    return scale_screen;
}

#pragma mark =========== 获取设备运营商 ===========
/**
 获取设备运营商
 
 @return 返回设备运营商
 */
- (NSString *)getDeviceCarrierName{
    
    //    #import <CoreTelephony/CTCarrier.h>
    //    #import <CoreTelephony/CTTelephonyNetworkInfo.h>
    CTCarrier *carrier = [[CTTelephonyNetworkInfo alloc] init].subscriberCellularProvider;
    NSString *name = carrier.carrierName?carrier.carrierName:@"";
    return name;
}

#pragma mark =========== 获取设备电量 ===========
/**
 获取设备电量
 
 @return 返回电量
 */
- (CGFloat)getDeviceElectricity{
    CGFloat batteryLevel=[[UIDevice currentDevice] batteryLevel];
    return batteryLevel;
}

#pragma mark =========== 获取精确的设备电量 ===========
/**
 获取精确的设备电量
 通过 runtime 获取电池电量控件类私有变量的值
 @return 返回电量
 */
- (CGFloat)getCurrentBatteryLevel{
    
    UIApplication *app = [UIApplication sharedApplication];
    
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        
        id status  = object_getIvar(app, ivar);
        
        for (id aview in [status subviews]) {
            
            int batteryLevel = 0;
            
            for (id bview in [aview subviews]) {
                
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    
                    if(ivar) {
                        
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            
                            return batteryLevel;
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

#pragma mark =========== 获取设备当前使用语言 ===========
/**
 获取设备当前使用语言
 
 @return 返回使用语言
 */
- (NSString *)getDeviceLanguage{
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = @"";
    if(languageArray.count)language = [languageArray objectAtIndex:0];
    return language;
}

#pragma mark =========== 获取电池充电状态 ===========
/**
 获取电池充电状态
 
 @return 返回充电状态(UnKnow：无法取得充电状态情况;Unplugged：不是充电状态;Charging：连接充电状态;Full：连接充满状态)
 */
- (NSString *)getBatteryState{
    UIDevice *device = [UIDevice currentDevice];
    if(device.batteryState ==UIDeviceBatteryStateUnknown){
        return @"UnKnow";
    }else if(device.batteryState ==UIDeviceBatteryStateUnplugged){
        return @"Unplugged";
    }else if(device.batteryState ==UIDeviceBatteryStateCharging){
        return @"Charging";
    }else if(device.batteryState ==UIDeviceBatteryStateFull){
        return @"Full";
    }
    return  nil;
}

#pragma mark =========== 获取设备内存大小 ===========
/**
 获取设备内存大小
 
 @return 返回内存大小
 */
- (long long)getTotalMemorySize{
    return [NSProcessInfo processInfo].physicalMemory;
}

#pragma mark =========== 获取当前设备可用内存 ===========
/**
 获取当前设备可用内存
 
 @return 返回可用内存
 */
- (double)getAvailableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

#pragma mark =========== 获取当前当前应用占用内存 ===========
/**
 获取当前当前应用占用内存
 
 @return 返回占用内存
 */
- (double)getAppUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

#pragma mark =========== 获取设备ip ===========
/**
 获取设备ip
 
 @param preferIPv4 是否是IPv4（YES:ipv4 NO:ipv6）
 @return 返回ip
 */
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

//获取所有相关IP信息
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark =========== 获取当前连接wifi名称 ===========
/**
 获取当前连接wifi名称
 
 @return 返回wifi名称
 */
- (NSString *)getWifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces)return nil;
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
}

#pragma mark =========== 调用系统短信提醒声 ===========
/**
 调用系统短信提醒声
 */
-(void)playSystemSound{
    SystemSoundID soundID = 1057;
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark =========== 判断相机相册是否有访问权限 ===========
/**
 *  调用系统相机
 */
- (BOOL)callCamera
{
    //判断是否已授权
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //无权限,可自行添加提示
//                ShowAlertView *alertView = [[ShowAlertView alloc] initWithTitle:@"温馨提示" msgStr:@"请前往设置->隐私->相机授权应用拍照权限" cancelTitle:@"" doneTitle:@"确定"];
//                [alertView show];
            }];
            
            return NO;
        }
    }
    return YES;
}
/**
 *  调用系统相册
 */
+ (void)callPhoto:(void(^)(BOOL status))isCan
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //可自行添加提示
//                ShowAlertView *alertView = [[ShowAlertView alloc] initWithTitle:@"温馨提示" msgStr:@"请前往设置->隐私->相册授权应用访问相册权限" cancelTitle:@"" doneTitle:@"确定"];
//                [alertView show];
            }];
            //无权限
            isCan(NO);
        }else{
            isCan(YES);
        }
    }
    else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusRestricted ||
                status == PHAuthorizationStatusDenied) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    可自行添加提示
//                    ShowAlertView *alertView = [[ShowAlertView alloc] initWithTitle:@"温馨提示" msgStr:@"请前往设置->隐私->相册授权应用访问相册权限" cancelTitle:@"" doneTitle:@"确定"];
//                    [alertView show];
                }];
                
                isCan(NO);
                
            }else{
                isCan(YES);
            }
        }];
    }
}

@end
