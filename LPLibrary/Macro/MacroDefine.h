//
//  MacroDefine.h
//  BerChinaQieCuo
//
//  Created by liuzhiqiong on 15/11/6.
//  Copyright © 2015年 北京宝润兴业发展科技股份有限公司. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h


#pragma mark =========== 系统 ===========
//当前系统语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//App版本Version
#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//App构建版本号
#define BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define BUILD_COUNT [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleGetInfoString"]
#define APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define ChANNELID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ChannelID"]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
//获取系统版本大于11
#define IS_IOS_11 ([[[UIDevice currentDevice] systemVersion] floatValue]>=11.0)?YES:NO

#define IS_IOS_11min ([[[UIDevice currentDevice] systemVersion] floatValue]<11.0)?YES:NO

//是否SDK版本大于9
#define IS_IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)?YES:NO

//是否SDK版本大于8
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)?YES:NO

//是否SDK版本大于7
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)?YES:NO

//是否SDK版本大于6
#define IS_IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)?YES:NO

//手机是否是iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KIphoneXNoneHeight (IS_IPHONE_X?20:0)

//状态栏，导航栏，工具栏高度
//#define StateBarHeight ((IS_IOS_7)?20:0)
//#define NavBarHeight ((IS_IOS_7)?64:44)
//#define TabbarHeight ((IS_IOS_7)?46:46)
#define StateBarHeight [UIApplication sharedApplication].statusBarFrame.size.height//(IS_IPHONE_X==YES)?44.0f: 20.0f
#define NavBarHeight ((IS_IPHONE_X)?88.0f: 64.0f)
#define TabbarHeight ((IS_IPHONE_X)?83.0f: 49.0f)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define WidthScale [UIScreen mainScreen].bounds.size.width/375.0
#define HeightScale [UIScreen mainScreen].bounds.size.height/667.0

//判断设备是否是ipad、iphone、retina屏
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD_PRO (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)

//-------------------------系统------------------------


#pragma mark =========== 打印日志 ===========
//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define NSLog(FORMAT, ...) nil
#endif

#pragma mark =========== 字符串判断 ===========
// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]
// 判断字符串输出判定
#define String_is_Null_Return_Str(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
//判断字符及对象是否为空
#define Object_is_Null(a) (a == nil || [a isEqual:[NSNull null]])
#define String_is_Null(a) (a == nil || [a isEqual:[NSNull null]])


#pragma mark =========== 图片 ===========
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//制单员广告图片比例(高:宽)
#define pictureScale (float)214/(float)750

//游客顶部图片比例(高:宽)
#define visitorPictureScale (float)364/(float)750



#pragma mark =========== 颜色 ===========
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//随机色
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#pragma mark =========== 内存 ===========
//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil


#pragma mark =========== 其他 ===========
// 定义静态常量字符串
#define py_staticConstString(__string)               static const char * __string = #__string;

//随机数
#define RandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//加载Nib
#define loadNib (name) [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].lastObject

//用户token设置
#define SetToken(string) [USER_DEFAULT setObject:string forKey:tokenKey]
#define UserToken (NSString*)[USER_DEFAULT objectForKey:tokenKey]

//用户云盾证书编码设置
#define SetCloudCertNum(string) [USER_DEFAULT setObject:string forKey:cloudCertNumKey]
#define CloudCertNum (NSString*)[USER_DEFAULT objectForKey:cloudCertNumKey]
#define SetCertEncode(string, key) [USER_DEFAULT setObject:string forKey:key]
#define CertEncode(key) [USER_DEFAULT objectForKey:key]

//启动广告页路径存储
#define SaveLaunchUrl(string) [USER_DEFAULT setObject:string forKey:launchAdUrlKey]
#define LaunchUrl (NSString*)[USER_DEFAULT objectForKey:launchAdUrlKey]

//弹出广告是否弹出过
#define SaveIsShowAlertAdStatus(string) [USER_DEFAULT setObject:string forKey:isShowAlertAdKey]
#define IsShowAlertAdStatus (NSString*)[USER_DEFAULT objectForKey:isShowAlertAdKey]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//防止循环引用宏定义
#define WeakSelf __weak __typeof__(self) weakself = self


#define KBrLogManager [BRlogManager defaultManager]

//代发工资最大金额位数
#define KMaxAmountInt 8
#define KmaxAmountDouble (KMaxAmountInt+3)

#endif /* MacroDefine_h */
