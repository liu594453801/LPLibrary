//
//  NSDate+Tool.h
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/5/2.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tool)


/**
 根据日期获取星期几

 @param date 日期
 @return 星期几
 */
+(NSString*)weekdayStringFromDate:(NSDate*)date;

/**
 根据日期获取年
 
 @param date 日期
 @return 年
 */
+(NSString*)getYear:(NSDate*)date;

/**
 根据日期获取月
 
 @param date 日期
 @return 月
 */
+(NSString*)getMonth:(NSDate*)date;

/**
 根据日期获取日
 
 @param date 日期
 @return 日
 */
+(NSString*)getDay:(NSDate*)date;

/**
 根据小时分钟判断当前时间点是否在某个时间段内
 
 @param startTime 开始时间，格式为：06:00
 @param expireTime 结束时间，格式为：23:59
 @return YES 在时间段内，NO 不在时间段内
 */
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime;


@end
