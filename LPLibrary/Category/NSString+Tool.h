//
//  NSString+Tool.h
//  FinancialCloud
//
//  Created by 刘鹏 on 15/11/20.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tool)

//空值字符串显示为@""
#pragma mark =========== 空值字符串默认显示为nullStr ===========
+(NSString*) getSafeStrWithStr:(id)str showNull:(NSString*)nullStr;

#pragma mark =========== json转dic ===========
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark =========== data转json ===========
+ (NSString*)dataToJsonString:(id)object;

#pragma mark =========== 检查输入是否为空 是否删除前后空壳 ===========
+(BOOL)CheckInputISNullBOOL:(id)inputTxt;

#pragma mark =========== 手机号码隐藏中间4位 ===========
+(NSString *)mobileHidenMiddle:(NSString*)mobileStr;

#pragma mark =========== 账号加*脱敏 ===========
+(NSString *)accountHidenMiddle:(NSString*)accountStr;

#pragma mark =========== 金额小写转大写 ===========
+(NSString *)changetoBigMoney:(NSString *)numStr;
//字符串SHA256加密
- (NSString*)sha256;

//URL编码字符串
+ (NSString *)urlEncode:(NSString *)srcString;

//根据请求参数获取云盾业务签名原文组合串
+ (NSString *)dealSignBusinessTextWithParamDic:(NSDictionary*)paramDic;

//清空反斜杠
+ (NSString *)clearBackslashWithStr:(NSString*)string;

// 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString;

//账号每4位加空格
+ (NSString *)addspaceWithString:(NSString *)string;

//对钱数字符串进行每隔三个字符添加一逗号的处理
+(NSString *)stringAddCommaFromStr:(NSString *)numStr;
/**
 货币处理
 ---增加千位符号(,)和2位小数点

 @param string 货币字符
 @return 货币处理后的字符
 */
+ (NSString *) currencyProcessing:(NSString *)string;

/**
 账号展示处理
 ---账号脱敏 + 每4位一个空格

 @param string 账号字符
 @return 账号处理后的字符
 */
+ (NSString *) accountProcessing:(NSString *)string;

//输入账号时处理每隔4位添加空格
+ (NSString *)inputAddSpaceWithStr:(NSString *)string;

/**
 账户可用余额处理
 
 @param balance 账户余额
 @param frozenAmount 账户冻结金额
 @return 可用余额：如果账户余额减去冻结金额小于或等于0，则显示0.00
 */
+ (NSString *) accountBalanceProcessing:(NSString *)balance frozenAmount:(NSString *)frozenAmount;

@end
