//
//  NSDate+Tool.m
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/5/2.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)

/**
 根据日期获取星期几
 
 @param date 日期
 @return 星期几
 */
+(NSString*)weekdayStringFromDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger week = [components weekday];
    
    NSString *weekDay = @"";
    switch (week) {
        case 1:
            weekDay=@"星期日";
            break;
        case 2:
            weekDay=@"星期一";
            break;
        case 3:
            weekDay=@"星期二";
            break;
        case 4:
            weekDay=@"星期三";
            break;
        case 5:
            weekDay=@"星期四";
            break;
        case 6:
            weekDay=@"星期五";
            break;
        case 7:
            weekDay=@"星期六";
            break;
            
        default:
            break;
    }
    
    return weekDay;
}

/**
 根据日期获取年
 
 @param date 日期
 @return 年
 */
+(NSString*)getYear:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger year = [components year];
    
    return [NSString stringWithFormat:@"%ld",year];
}

/**
 根据日期获取月
 
 @param date 日期
 @return 月
 */
+(NSString*)getMonth:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger month = [components month];
    
    return [NSString stringWithFormat:@"%02ld",month];
}

/**
 根据日期获取日
 
 @param date 日期
 @return 日
 */
+(NSString*)getDay:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger day = [components month];
    
    return [NSString stringWithFormat:@"%02ld",day];
}

/**
 根据小时分钟判断当前时间点是否在某个时间段内

 @param startTime 开始时间，格式为：06:00
 @param expireTime 结束时间，格式为：23:59
 @return YES 在时间段内，NO 不在时间段内
 */
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString * todayStr=[dateFormat stringFromDate:today];
    today=[ dateFormat dateFromString:todayStr];
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

@end
