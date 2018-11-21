//
//  PublicClass.m
//  BerchinaQieCuo
//
//  Created by 刘鹏 on 15-5-13.
//  Copyright (c) 2015年 北京宝润兴业科技有限公司. All rights reserved.
//

#import "PublicClass.h"
#import <LPLibrary/MacroDefine.h>

@implementation PublicClass

#pragma mark 检查输入是否为空 是否删除前后空壳
+(BOOL)CheckInputISNullBOOL:(id)inputTxt isD_FBSpace:(BOOL)isD_FBSpace{
    
    if ([inputTxt isKindOfClass:[NSString class]]) {
        NSString *inputStr = [NSString stringWithFormat:@"%@",inputTxt];
        if (isD_FBSpace) {//需要去掉前后空格进行判断
            inputStr = [inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
        
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

#pragma mark 检查输入是否含有特殊字符
+(BOOL)IsIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"?.-~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

#pragma mark 检查输入是否含有空格
+(BOOL)IsIncludeSpace: (NSString *)str {
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    }else {
        return NO;
    }
}
#pragma mark 检查邮箱格式是否正确
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark 压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark image对应UIImagView大小来按比例压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image imageView:(UIImageView*)imageView
{
    if (image.size.width > imageView.frame.size.width || image.size.height > imageView.frame.size.height) {
        if (image.size.width > imageView.frame.size.width && image.size.height <= imageView.frame.size.height) {
            return [PublicClass imageWithImageSimple:image scaledToSize:CGSizeMake(imageView.frame.size.width, image.size.height*(imageView.frame.size.width/image.size.width))];
        }else if (image.size.height > imageView.frame.size.height && image.size.width <= imageView.frame.size.width) {
            return [PublicClass imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width*(imageView.frame.size.height/image.size.height),imageView.frame.size.height)];
        }else{
            if ((image.size.width/imageView.frame.size.width) <= (image.size.height/imageView.frame.size.height)) {
                return [PublicClass imageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width*(imageView.frame.size.height/image.size.height),imageView.frame.size.height)];
            }else{
                return [PublicClass imageWithImageSimple:image scaledToSize:CGSizeMake(imageView.frame.size.width,image.size.height*(imageView.frame.size.width/image.size.width))];
            }
        }
    }else{
        UIImage *oldImage = image;
        return oldImage;
    }
}

#pragma mark UILabel自适应大小
+(CGSize)setUILabelSizeWithLabelText:(NSString*)text font:(CGFloat)fontSize xianHeight:(CGFloat)height xianWidth:(CGFloat)width
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    //设置一个行高上限
    CGSize size = CGSizeMake(width,height);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    labelsize = [text boundingRectWithSize:size options:(NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attribute context:nil].size;
    
    return labelsize;
}

#pragma mark 给视图添加细线
+ (void)setLineFatherView:(UIView*)view lineFrame:(CGRect)rect lineColor:(UIColor*)color
{
    UIView *lineview = [[UIView alloc] initWithFrame:rect];
    lineview.tag = 11111111;
    lineview.backgroundColor = color;
    [view sendSubviewToBack:lineview];
    [view addSubview:lineview];
}

#pragma mark 16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma mark 16进制颜色转换UIImage
+(UIImage *)drawcolorInImage:(NSString *)colorName{
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [[PublicClass colorWithHexString:colorName] CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage * imge;// = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imge;
}

#pragma mark -- 判断是否是手机号码
+ (BOOL)isPhoneNum:(NSString*)string{
    if (string.length != 11) {
        return NO;
    }
    NSUInteger lengthOfString = string.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
        unichar character = [string characterAtIndex:loopIndex];
        if (loopIndex == 0) {
            if (character!=49) {//判断第一位是否为1
                return NO;
            }
        }else
            if (character < 48 || character > 57)
                return NO; // 48 unichar for 0
    }
    return YES;
}

#pragma mark -- 用户名，密码
//用户名
+ (BOOL)validateUsername:(NSString *)username
{
    //NSString *usernameRegex = @"^[a-zA-Z0-9_@\u4e00-\u9fa5]{4,20}$";
    NSString *usernameRegex = @"^[a-zA-Z0-9_@]{4,20}$";//去掉中文
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",usernameRegex];
    return [passWordPredicate evaluateWithObject:username];
}

//密码
+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9_@\u4e00-\u9fa5]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//只能输入数字及字母
+ (BOOL) validateInputStr:(NSString *)inputWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9-/]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:inputWord];
}
#pragma mark -
#pragma mark - 验证手机,邮箱
/**
 *  验证输入字符串输入格式是否正确
 *
 *  @param inputString    输入Str
 *  @param limitMinLength 限制最小长度
 *  @param limitMaxLength 限制最大长度
 *  @param nType          不同验证方式
                    0:   //验证输入内容只输入中文、英文、数字
                    1:   //验证输入内容只输入中文、英文、数字、下划线
                    2:   //验证输入内容只输入英文、数字
                    3:   //验证邮箱格式输入
                    4:   //验证手机格式输入
 *
 *  @return 是否正确
 */
+ (BOOL)validateInputString:(NSString *)inputString limitMinLength:(NSInteger)limitMinLength limitMaxLength:(NSInteger)limitMaxLength nType:(NSInteger)nType
{
    switch (nType) {
        case 0:   //验证输入内容只输入中文、英文、数字
        {
            NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9@\u4e00-\u9fa5]{%ld,%ld}$",(long)limitMinLength,limitMaxLength];
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:inputString];
        }
            break;
        case 1:   //验证输入内容只输入中文、英文、数字、下划线
        {
            NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9_@\u4e00-\u9fa5]{%ld,%ld}$",(long)limitMinLength,limitMaxLength];
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:inputString];
        }
            break;
        case 2:   //验证输入内容只输入英文、数字
        {
            NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%ld,%ld}$",limitMinLength,(long)limitMaxLength];
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:inputString];
        }
            break;
        case 3:   //验证邮箱格式输入
        {
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:inputString];
        }
            break;
        case 4:   //验证手机格式输入
        {
            NSString *emailRegex = @"^(1[0-9])\\d{9}$";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:inputString];
        }
            break;
        case 5:   //传真
        {
//            NSString *phoneRegex = @"^(?:(?:0\d{2,3}[- ]?[1-9]\d{6,7})|(?:[48]00[- ]?[1-9]\d{6}))$";
            NSString *passWordRegex = [NSString stringWithFormat:@"^(?:(?:0\\d{2,3}[- ]?[1-9]\\d{6,7})|(?:[48]00[- ]?[1-9]\\d{6}))$"];
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
            return [phoneTest evaluateWithObject:inputString];
        }
            break;
        case 6:   //只输入金额
        {
            NSString *phoneRegex = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            return [phoneTest evaluateWithObject:inputString];
        }
            break;
            
        case 7:   //只输入数字
        {
            NSString *phoneRegex = [NSString stringWithFormat:@"^\\d{%ld,%ld}$",(long)limitMinLength,limitMaxLength];
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            return [phoneTest evaluateWithObject:inputString];
        }
            break;
            
        case 8:   //电话规则
        {
            NSString *phoneRegex = [NSString stringWithFormat:@"^(\\d{3,4}\\-?)?\\d{6,12}$"];
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            return [phoneTest evaluateWithObject:inputString];
        }
            break;
        case 9:   //昵称规则（中英文，数字，-,_）
        {
            NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9-_@\u4e00-\u9fa5]{%ld,%ld}$",(long)limitMinLength,limitMaxLength];
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:inputString];
        }
            break;
        case 10:   //身份证校验规则
        {
            NSString *passWordRegex = [NSString stringWithFormat:@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$|^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"];
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:inputString];
        }
            break;
        case 11:   //中文、英文
        {
            NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z\u4e00-\u9fa5]{%ld,%ld}$",(long)limitMinLength,limitMaxLength];
            NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
            return [passWordPredicate evaluateWithObject:inputString];
        }
            break;
            
        default:
            break;
    }
    return YES;
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以11，13，14，15，17，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((11[0-9])|(14[0-9])|(13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
    
}

+(BOOL)isNumber:(NSString *)textString
{
    
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
    
}

//判断是数字，可以是整数，如果是小数必须是两位小数
+ (BOOL) isDigitWithTwoDecimal:(NSString *)number
{
    
    NSString *regex = @"^[0-9]+(\\.[0-9]{1,2})?$";
            NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numberTest evaluateWithObject:number];

}


//验证中文输入长度
+ (NSString*) validateChinaLimitNum:(int)maxLimitNum textField:(UITextField*)textField inputModeStr:(NSString*)inputModeStr
{
    NSString *toBeString = textField.text;
    
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; //键盘输入模式
    if ([inputModeStr isEqualToString:@"zh-Hans"]) { //键盘为中文键盘
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *postion = [textField positionFromPosition:selectedRange.start offset:0];
        if (!postion) {
            //没有高亮选择的字
            if (toBeString.length > maxLimitNum) {
                return [toBeString substringToIndex:maxLimitNum];
            }else{ //有高亮选择的字符串，则暂不对文字进行统计和限制
                
            }
        }
    }else{
        if (toBeString.length > maxLimitNum) {
            return [toBeString substringToIndex:maxLimitNum];
        }
    }
    return toBeString;
}

#pragma mark --将时间转成时间戳
+(NSString *)getTimeIntervalStringFromNowDate:(NSInteger)type Anddate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (type==0) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    }else if (type==1){
        [formatter setDateFormat:@"yyyy-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    }else if (type==2){
        [formatter setDateFormat:@"yyyyMMdd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    }
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSString *nowtimeStr = [formatter stringFromDate:date];//----------将nsdate按formatter格式转成nsstring
    
//    NSLog(@"nowtimeStr:%@",nowtimeStr);
    //    时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];//*1000
//    NSLog(@"timeSp:%@",timeSp);
    return timeSp;
}

#pragma mark --时间字符串转成当前时间date(Nsdate)
+(NSDate *)getDateByIntervalWithdatestr:(NSString *)datestr type:(int)type
{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (type == 0) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else if (type == 1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (type == 2) {
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    }
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *timedate = [formatter dateFromString:datestr];
    
//    NSString *stringFromDate = [formatter stringFromDate:date];
    return timedate;
}
#pragma mark --当前时间date(Nsdate)转成时间字符串
+(NSString *)getDateStrByDate:(NSDate *)date type:(int)type
{
    //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (type == 0) {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }else if (type == 1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:ss"];
    }else if (type == 2) {
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:ss"];
    }else if (type == 3) {
        [formatter setDateFormat:@"yyyyMMdd"];
    }
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

#pragma mark --时间戳转成当前时间
+(NSString *)getDateByIntervalWithTimeCuo:(NSTimeInterval)intervalTime type:(int)type
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];

    switch (type) {
        case 1:
        {
            [formatter setDateFormat:@"yyyy年MM月dd日"];
        }
            break;
        case 2:
        {
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        }
            break;
        case 3:
        {
            [formatter setDateFormat:@"MM月dd日 HH:mm"];
        }
            break;
        case 4:
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case 5:
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
            break;
        case 6:
        {
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        }
            break;
        case 7:
        {
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        }
            break;
        case 8:
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
            break;
        case 9:
        {
            [formatter setDateFormat:@"yyyyMMdd"];
        }
        case 10:
        {
            [formatter setDateFormat:@"yyyy/MM/dd"];
        }
            break;
        default:
            break;
    }
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    if (intervalTime > 0) {
        return stringFromDate;
    }
    return @"";
}

+(NSString *)getTimeChuoWithdateStr:(NSString *)dateStr type:(int)type
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (type == 0) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else if (type == 1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if (type == 2) {
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    }else if (type == 3) {
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    }else if (type == 4) {
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }else if (type == 5) {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }else if (type == 6) {
        [formatter setDateFormat:@"yyyyMMdd"];
    }else if (type == 7) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];//
    
    return timeSp;
}


+(NSString *)getTimeChuoHaveHourWithdateStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];//
    
    return timeSp;
}

+ (NSString *)getTimeChuoHaveYear:(NSString *)dateStr {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];//
    
    return timeSp;
}

+(NSString *)getTimeChuoHaveHourWithStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];//
    
    return timeSp;
}


+(NSString *)getTimeChuoContainHourWithdateStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [formatter dateFromString:dateStr];
    
     NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970]*1000)];//
    
    return timeSp;
}
#pragma mark --根据开始时间结束时间计算时间差值
+(NSTimeInterval)getTotalTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime type:(int)type{
    //按照日期格式创建日期格式句柄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (type == 0) {
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    }else if (type == 1) {
        [dateFormatter setDateFormat:@"yyyyMMdd"];
    }
    
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    //将日期字符串转换成Date类型
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    //将日期转换成时间戳
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [endDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    return value;
//    //计算具体的天，时，分，秒
//    int second = (int)value %60;//秒
//    int minute = (int)value / 60 % 60;
//    int house = (int)value / 3600;
//    int day = (int)value / (24 * 3600);
//    int month = (int)value / (30 * 24 * 3600);
//    //将获取的int数据重新转换成字符串
//    NSString *str;
//    if (day != 0) {
//        str = [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,house,minute,second];
//    }else if (day==0 && house != 0) {
//        str = [NSString stringWithFormat:@"%d小时%d分%d秒",house,minute,second];
//    }else if (day== 0 && house== 0 && minute!=0) {
//        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
//    }else{
//        str = [NSString stringWithFormat:@"%d秒",second];
//    }
//    //返回string类型的总时长
//    return str;
}

#pragma mark --根据传入时间得出友好提示信息
+(NSString*)getFriendlyTime:(NSDate *)dateTime type:(int)type{
    //将日期转换成时间戳
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970]*1;
    NSTimeInterval input = [dateTime timeIntervalSince1970]*1;
    NSTimeInterval value = current - input;
    if (value<=0) {//传入时间大于当前时间，显示年月日（可根据业务显示不同格式时间）
        return [PublicClass getDateByIntervalWithTimeCuo:input type:type];
    }else{
        //计算具体的月，天，时，分，秒
        int second = (int)value;//秒
        int minute = (int)value / 60;
        int hour = (int)value / 3600;
        int day = (int)value / (24 * 3600);
        int month = (int)value / (30 * 24 * 3600);
        //将获取的int数据重新转换成字符串
        NSString *str;
        if (day == 0) {
            if (hour == 0) {
                if (minute>0) {
                    return [NSString stringWithFormat:@"%d分钟前",minute];
                }else{
                    return [NSString stringWithFormat:@"当前"];
                }
            }else{
                return [NSString stringWithFormat:@"%d小时前",hour];
            }
        }else if (day == 1) {
            return [NSString stringWithFormat:@"%d小时前",hour];
        }else if (day == 2) {
            return [NSString stringWithFormat:@"%d小时前",hour];
        }else if (day >= 3) {
            return [PublicClass getDateByIntervalWithTimeCuo:input type:type];
        }else{
            return [PublicClass getDateByIntervalWithTimeCuo:input type:type];
        }
    }
}

#pragma mark 根据宽度对图片等比压缩处理
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    NSLog(@"压缩成功");
    return newImage;
}

#pragma mark - 给视图添加阴影
+(void)AddShadow:(UIView*)view{
    
    [[view layer] setShadowOffset:CGSizeMake(1, 0)]; // 阴影的范围
    [[view layer] setShadowRadius:2];                // 阴影扩散的范围控制
    [[view layer] setShadowOpacity:0.3];               // 阴影透明度
    [[view layer] setShadowColor:[UIColor grayColor].CGColor]; // 阴影的颜色
    
}

#pragma mark - 随机产生的数字字符串
+ (NSString *)generatesRandNum
{
    const int N = 10;
    
    NSString *sourceString = @"0123456789";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    // 时间随机值
    srand((int)time(0));
    
    for (int i = 0; i < N; i++)
    {
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    return result;
    
}

#pragma mark －产生可以输入文本的弹出框
+(UIAlertController *)setupTextAlertViewInVC:(UIViewController *)VC withTitle:(NSString *)title message:(NSString *)message withkeybords:(NSInteger)type confirmBlock:(void (^)(id count))confirm cancelBlock:(void (^)(id count))cancel
{
#warning ---- 使用最新的的提示框图层覆盖不了返回金融云那个按钮 暂时没有想到好的解决方法
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
        
        if (cancel){
            cancel(@"");
        }
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *textField = alertController.textFields.firstObject;
        [textField resignFirstResponder];
        if (confirm){
            confirm(textField.text);
        }
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        //默认键盘
        if (type == 0) {
            textField.keyboardType =  UIKeyboardTypeDefault;
             textField.secureTextEntry =  YES;
        //数字键盘
        }else if (type == 1){
            
             textField.keyboardType = UIKeyboardTypeDecimalPad;
           
            
        }
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [VC presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
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
    if (![PublicClass CheckInputISNullBOOL:leftNumStr]) {
        return numStr;
    }
    
    if (![PublicClass validateInputString:leftNumStr limitMinLength:0 limitMaxLength:10000 nType:7]) {
        return numStr;
    }
    
    if ([PublicClass CheckInputISNullBOOL:rightNumStr]) {
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
    if ([PublicClass CheckInputISNullBOOL:rightNumStr isD_FBSpace:NO]) {
        returnStr = [returnStr stringByAppendingString:[@"." stringByAppendingString:rightNumStr]];
    }
    
    return returnStr;
}

#pragma mark 检查输入是否为空
+(BOOL)CheckInputISNullBOOL:(id)inputTxt{
    
    if ([inputTxt isKindOfClass:[NSString class]]) {
        if ([inputTxt isEqualToString:@"(null)"]||[[inputTxt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<1 || inputTxt==nil||[inputTxt isEqual:@""]||[inputTxt isEqualToString:@"null"]||inputTxt==nil||inputTxt==NULL||[inputTxt isEqualToString:@" "]) {
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

#pragma mark 空值字符串显示为nullStr
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

#pragma mark 获取当前年月日 year month day
+ (NSDictionary *) getCurrentDate{
    
    NSDate *currentdat = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentdat];
    int currentyear = (int) [dateComponent year];
    int currentmonth = (int)[dateComponent month];
    int currentday   = (int)[dateComponent day];
    int hour = (int)[dateComponent hour];
    int min = (int)[dateComponent minute];
    return @{
             @"year":[NSNumber numberWithInt:currentyear],
             @"month":[NSNumber numberWithInt:currentmonth],
             @"day":[NSNumber numberWithInt:currentday],
             @"hour":[NSNumber numberWithInt:hour],
             @"min":[NSNumber numberWithInt:min]
             };
}

#pragma mark - UILabel文本自适应高
+ (CGRect)adaptOriginalFrame:(CGRect)frame withStrText:(NSString *)text withFont:(UIFont *)font{

    CGRect Aframe = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,
                                           frame.size.height =[text boundingRectWithSize:
                                                                  CGSizeMake(frame.size.width, CGFLOAT_MAX)
                                                                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size.height);
    
    return Aframe;
}

+(UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
    
//    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController *topController = nil;
//    if ([rootVC isKindOfClass:[UITabBarController class]]) {
//        UITabBarController *tabbar = (UITabBarController *)rootVC;
//        NSInteger index = tabbar.selectedIndex;
//        topController = tabbar.childViewControllers[index];
//    }else if ([rootVC isKindOfClass:[UINavigationController class]]) {
//        topController = rootVC;
//    }else if ([rootVC isKindOfClass:[UIViewController class]]) {
//        topController = rootVC;
//    }
//    return topController;
}

#pragma mark - 根据字体大小获取文本宽度
+(CGFloat) getWidthWithFontSize:(CGFloat)fontSize textStr:(NSString*)textStr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [textStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

#pragma mark - 根据字体大小获取文本高度
+(CGFloat) getHeightWithFontSize:(CGFloat)fontSize textStr:(NSString*)textStr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [textStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


#pragma mark - 获取某年某月的天数
+ (NSInteger)howManyDaysWithYear:(NSInteger)year month:(NSInteger) month {
    
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

BOOL isNullValue(id obj){
    return !([PublicClass CheckInputISNullBOOL:obj]);
}

NSString *safeString(id obj){
    bool ret = isNullValue(obj);
    if (ret) {
        return @"";
    }else{
        return (NSString*)obj;
    }
}

@end
