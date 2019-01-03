//
//  NSString+Tool.m
//  FinancialCloud
//
//  Created by 刘鹏 on 15/11/20.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import "NSString+Tool.h"
//#import <LPLibrary/PublicClass.h>

@implementation NSString (Tool)

//空值字符串显示为@""
+(NSString*) getSafeStrWithStr:(id)str showNull:(NSString*)nullStr
{
    NSString *strSafe = [NSString stringWithFormat:@"%@",str];
    if ([strSafe isEqualToString:@"(null)"]||[[strSafe stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<1 || strSafe==nil||[strSafe isEqual:@""]||[strSafe isEqualToString:@"null"]||strSafe==nil||strSafe==NULL||[strSafe isEqualToString:@" "]) {
        //        NSLog(@"FAlse");
        return nullStr;
    }
    else
    {
        return strSafe;
    }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+(NSString*)dataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return jsonString;
}

#pragma mark 检查输入是否为空 是否删除前后空壳
+(BOOL)CheckInputISNullBOOL:(id)inputTxt{
    
    if ([inputTxt isKindOfClass:[NSString class]]) {
        NSString *inputStr = [NSString stringWithFormat:@"%@",inputTxt];
//        if (isD_FBSpace) {//需要去掉前后空格进行判断
//            inputStr = [inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        }
        
        if ([inputStr isEqualToString:@"(null)"]||[[inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<1 || inputStr==nil||[inputStr isEqual:@""]||[inputStr isEqualToString:@"null"]||inputStr==nil||inputStr==NULL||[inputStr isEqualToString:@" "]) {
            //        NSLog(@"FAlse");
            return FALSE;
        }
    }else if([inputTxt isKindOfClass:[NSNumber class]]){
        if ([[NSString stringWithFormat:@"%@",inputTxt] doubleValue]>0) {
            return TRUE;
        }else{
            return FALSE;
        }
    }else if ([inputTxt isKindOfClass:[NSObject class]]){
        return FALSE;
    }else if ([[inputTxt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<1){
        return FALSE;
    }
    return TRUE;
}

//手机号码隐藏中间4位
+(NSString *)mobileHidenMiddle:(NSString*)mobileStr {
    NSString *emailRegex = @"^(1[0-9])\\d{9}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isMobile = [emailTest evaluateWithObject:mobileStr];
    
    if (isMobile) {//如果是手机号码的话
        
        NSString *newMobileStr = [mobileStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return newMobileStr;
        
    }
    return mobileStr;
    
}

//账号加*脱敏 ===========前4位明码+8位掩码+后4位明码，如8000********2367
+(NSString *)accountHidenMiddle:(NSString*)accountStr {
    if (accountStr.length >= 8) {
        NSString *front4Str = [accountStr substringToIndex:4];
        NSString *back4Str = [accountStr substringFromIndex:accountStr.length-4];
        NSString *newStr = [NSString stringWithFormat:@"%@********%@",front4Str,back4Str];
        return newStr;
    }
    return accountStr;
}


//URL编码字符串
+ (NSString *)urlEncode:(NSString *)srcString
{
    NSString* escapedUrlString  =[srcString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "]];
    return escapedUrlString;
}

+(NSString *)changetoBigMoney:(NSString *)numStr{
    
    if ([numStr isEqualToString:@"0"]) {
        return @"零元整";
    }
    
    //转化成double类型
    double numberals = [numStr doubleValue];
    
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    
    //金额乘以100转换成字符串（去除圆角分数值）
    
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    
    NSLog(@"valstr: %@",valstr);
    
    
    
    NSString *prefix;
    
    NSString *suffix;
    
    
    
    NSLog(@"%lu",(unsigned long)valstr.length);
    
    
    
    if (valstr.length <= 2)
        
    {
        
        prefix=@"零元";
        
        
        
        if (valstr.length == 0)
            
        {
            
            suffix=@"零角零分";
            
        }
        
        else if (valstr.length == 1)
            
        {
            
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
            
        }
        
        else
            
        {
            
            NSString *head = [valstr substringToIndex:1];
            
            NSString *foot = [valstr substringFromIndex:1];
            
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
            
        }
        
    }
    
    else
        
    {
        
        prefix=@"";
        
        suffix=@"";
        
        
        
        int flag = (int)valstr.length - 2;
        
        NSLog(@"flag: %d",flag);
        
        
        
        NSString *head = [valstr substringToIndex:flag-1];
        
        NSLog(@"head: %@",head);
        
        
        
        NSString *foot = [valstr substringFromIndex:flag];
        
        NSLog(@"foot: %@",foot);
        
        
        
        if (head.length>13)
            
        {
            
            return @"数值太大（最大支持13位整数），无法处理";
            
        }
        
        //处理整数部分
        
        NSMutableArray * ch = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < head.length; i++)
            
        {
            
            NSLog(@"head[i]: %hu",[head characterAtIndex:i]);
            
            
            
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            
            [ch addObject:str];
            
            
            
//            NSLog(@"ch: %@",ch);
            
        }
        
//        NSLog(@"ch_All: %@",ch);
        
        
        
        
        
        int zeronum = 0;
        
        
        
//        NSLog(@"ch.count: %ld",ch.count);
        
        for (int i = 0; i < ch.count; i++)
            
        {
            
            int index = (ch.count - i - 1) % 4;//取段内位置
            
            NSLog(@"index: %d",index);
            
            
            
            int indexloc = (int)(ch.count - i - 1) / 4;//取段位置
            
            NSLog(@"indexloc: %d",indexloc);
            
            
            
            
            
            NSLog(@"ch[i]: %@",[ch objectAtIndex:i]);
            
            if ([[ch objectAtIndex:i] isEqualToString:@"0"])
                
            {
                
                zeronum++;
                
            }
            
            else
                
            {
                
                if (zeronum != 0)
                    
                {
                    
                    if (index != 3)
                        
                    {
                        
                        prefix=[prefix stringByAppendingString:@"零"];
                        
                    }
                    
                    zeronum = 0;
                    
                }
                
                prefix = [prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                
                prefix = [prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
                
            }
            
            if (index == 0 && zeronum < 4)
                
            {
                
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
                
            }
            
        }
        
        prefix = [prefix stringByAppendingString:@"元"];
        
        //处理小数位
        
        if ([foot isEqualToString:@"00"])
            
        {
            
            suffix =[suffix stringByAppendingString:@"整"];
            
        }
        
        else if ([foot hasPrefix:@"0"])
            
        {
            
            NSString * footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            
            suffix = [NSString stringWithFormat:@"零%@分",[numberchar objectAtIndex:[footch intValue]]];
            
        }
        
        else
            
        {
            
            NSString * headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            
            NSString * footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            
            suffix = [NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
            
        }
        
    }
    
    return [prefix stringByAppendingString:suffix];
}

//根据请求参数获取云盾业务签名原文组合串
+ (NSString *)dealSignBusinessTextWithParamDic:(NSDictionary*)paramDic {
    NSString *busStr= @"";
    for (int i=0; i<paramDic.allKeys.count;i++) {
        NSString *key = paramDic.allKeys[i];
        if (i == (paramDic.allKeys.count-1)) {
            busStr = [NSString stringWithFormat:@"%@%@=%@",busStr,key,[paramDic objectForKey:key]];
        }else{
            busStr = [NSString stringWithFormat:@"%@%@=%@&",busStr,key,[paramDic objectForKey:key]];
        }
    }
    return busStr;
}

//清空反斜杠
+ (NSString *)clearBackslashWithStr:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
}

// 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString
{
    if (aString.length>0) {
        aString = [aString substringToIndex:1];
    }
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
//    //转成了可变字符串
//    NSMutableString *str = [NSMutableString stringWithString:aString];
//    //先转换为带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
//    //再转换为不带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [mutableString capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

//账号每4wei加空格
+ (NSString *)addspaceWithString:(NSString *)string {
    NSString *tempStr=string;
    NSInteger size =(tempStr.length / 4);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    NSString *extraStr = [tempStr substringWithRange:NSMakeRange(size*4, (tempStr.length%4))];
    if (![extraStr isEqualToString:@""]) {
        [tmpStrArr addObject: extraStr];
    }
    tempStr = [tmpStrArr componentsJoinedByString:@" "];
    return tempStr;
}

//输入账号时处理每隔4位添加空格
+ (NSString *)inputAddSpaceWithStr:(NSString *)string {
    if (![NSString CheckInputISNullBOOL:string]) {
        return @"";
    }
    NSString *newStr = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [NSString addspaceWithString:newStr];
}


+ (NSString *)transformToPinyin:(NSString*)string {
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

#pragma mark 对钱数字符串进行每隔三个字符添加一逗号的处理
+(NSString *)stringAddCommaFromStr:(NSString *)numStr{
    
    //分割小数点左右字符串
    NSArray *array = [numStr componentsSeparatedByString:@"."];
    
    NSString *leftNumStr = [NSString string];
    NSString *rightNumStr = [NSString string];
    if (array.count > 0) {
        leftNumStr = array[0];
        if (array.count == 2) {
            rightNumStr = array[1];
        }
    }
    if (![NSString CheckInputISNullBOOL:leftNumStr]) {
        return numStr;
    }
    
    NSString *numRegex = [NSString stringWithFormat:@"^\\d{%ld,%ld}$",(long)0,(long)10000];
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    if (![numTest evaluateWithObject:leftNumStr]) {
        return numStr;
    }
    
    if ([NSString CheckInputISNullBOOL:rightNumStr]) {
        if (rightNumStr.length == 1) {
            rightNumStr = [rightNumStr stringByAppendingString:@"0"];
        }
    }else{
        rightNumStr = @"00";
    }
    
    //添加操作
    int count = 0;
    long long int a = leftNumStr.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:leftNumStr];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    //重新拼接小数点
    NSString *returnStr = newstring;
    if ([NSString CheckInputISNullBOOL:rightNumStr]) {
        returnStr = [returnStr stringByAppendingString:[@"." stringByAppendingString:rightNumStr]];
    }
    
    return returnStr;
}

/**
 货币处理
 ---增加千位符号(,)和2位小数点
 
 @param string 货币字符
 @return 货币处理后的字符
 */
+ (NSString *) currencyProcessing:(NSString *)string{
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:[NSString getSafeStrWithStr:string showNull:@"0.00"]];
    //NSString *currencyStr = [NSString stringWithFormat:@"%.2f", [[NSString stringWithFormat:@"%@", amount] floatValue]];
    NSString *currencyStr = [NSString stringWithFormat:@"%@", amount];
    return [NSString stringAddCommaFromStr:currencyStr];
}

/**
 账号展示处理
 ---账号脱敏 + 每4位一个空格
 
 @param string 账号字符
 @return 账号处理后的字符
 */
+ (NSString *) accountProcessing:(NSString *)string{
    NSString *accountStr = [self accountHidenMiddle:[self getSafeStrWithStr:string showNull:@""]];
    return [self addspaceWithString:accountStr];
}

/**
 账户可用余额处理

 @param balance 账户余额
 @param frozenAmount 账户冻结金额
 @return 可用余额：如果账户余额减去冻结金额小于或等于0，则显示0.00
 */
+ (NSString *) accountBalanceProcessing:(NSString *)balance frozenAmount:(NSString *)frozenAmount{
    NSDecimalNumber *balanceNumber = [NSDecimalNumber decimalNumberWithString:[NSString getSafeStrWithStr:balance showNull:@"0.00"]];
    NSDecimalNumber *frozenAmountNumber = [NSDecimalNumber decimalNumberWithString:[NSString getSafeStrWithStr:frozenAmount showNull:@"0.00"]];
    //保留两位并四舍五入
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    // 计算计算保留两位并四舍五入
    NSDecimalNumber *realReduceMoneyNum = [balanceNumber decimalNumberBySubtracting:frozenAmountNumber withBehavior:roundUp];
    if ([realReduceMoneyNum doubleValue] > 0){
        return [NSString stringWithFormat:@"%.2f", [realReduceMoneyNum doubleValue]];
    }else{
        return @"0.00";
    }
}

/**
 URL编码

 @return 编码后w字符串
 */
- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}


@end
