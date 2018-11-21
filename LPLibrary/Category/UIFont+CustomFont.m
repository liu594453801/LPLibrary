//
//  UIFont+CustomFont.m
//  SalesManager
//
//  Created by ZpyZp on 16/1/22.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)

#pragma mark =========== systemFontOfSize ===========
/**
 文字一级字体 （导航栏字体）
 */
+ (UIFont *)Font19
{
    return [UIFont systemFontOfSize:19];
}
+ (UIFont *)Font18
{
    return [UIFont systemFontOfSize:18];
}
/**
 文字二级字体 （重要的文字和标题,使用频率较高）
 */
+ (UIFont *)Font17
{
    return [UIFont systemFontOfSize:17];
}
+ (UIFont *)Font16
{
    return [UIFont systemFontOfSize:16];
}
/**
 文字三级字体 （较为重要的文字和小标题,使用频率较高）
 */
+ (UIFont *)Font15
{
    return [UIFont systemFontOfSize:15];
}
/**
 文字四级字体 （部分文字,或者辅助性标题，使用频率一般）
 */
+ (UIFont *)Font14
{
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)Font13
{
    return [UIFont systemFontOfSize:13];
}
/**
 文字五级字体 （内容，辅助性文字，底部菜单文字，使用频率一般）
 */
+ (UIFont *)Font12
{
    return [UIFont systemFontOfSize:12];
}
/**
 文字六级字体 （应用页面标签内容，使用频率较少）
 */
+ (UIFont *)Font11
{
    return [UIFont systemFontOfSize:11];
}
/**
 文字七级字体 （应用页面标签内容，使用频率较少）
 */
+ (UIFont *)Font10
{
    return [UIFont systemFontOfSize:10];
}

#pragma mark =========== UIFontWeightMedium ===========
+ (UIFont *)FontMedium40
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:40 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:40];
    }
}
+ (UIFont *)FontMedium20
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:20];
    }
}
+ (UIFont *)FontMedium19
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:19];
    }
}

+ (UIFont *)FontMedium18
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:18];
    }
}

+ (UIFont *)FontMedium17
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:17];
    }
}
+ (UIFont *)FontMedium16
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:16];
    }
}
/**
 文字三级字体 （较为重要的文字和小标题,使用频率较高）
 */
+ (UIFont *)FontMedium15
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:15];
    }
}
/**
 文字四级字体 （部分文字,或者辅助性标题，使用频率一般）
 */
+ (UIFont *)FontMedium14
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:14];
    }
}
+ (UIFont *)FontMedium13
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:13];
    }
}
/**
 文字五级字体 （内容，辅助性文字，底部菜单文字，使用频率一般）
 */
+ (UIFont *)FontMedium12
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:12];
    }
}
/**
 文字六级字体 （应用页面标签内容，使用频率较少）
 */
+ (UIFont *)FontMedium11
{
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
    } else {
        // Fallback on earlier versions
        return [UIFont boldSystemFontOfSize:11];
    }
}

@end

