//
//  BCSDictionary.m
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/9/15.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "NSDictionary+Tool.h"

@implementation NSDictionary(Tool)


// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)descriptionWithLocale:(id)locale{
    
    if (![self count]) {
        return @"";
    }
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                  withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    
    [NSPropertyListSerialization propertyListWithData:tempData
                                              options:NSPropertyListImmutable
                                               format:NULL
                                                error:NULL];
    return str;
    
}

@end
