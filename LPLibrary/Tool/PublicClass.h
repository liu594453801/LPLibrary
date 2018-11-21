//
//  PublicClass.h
//  BerchinaQieCuo
//
//  Created by 刘鹏 on 15-5-13.
//  Copyright (c) 2015年 北京宝润兴业科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicClass : NSObject 

#pragma mark 检查输入是否为空
+(BOOL) CheckInputISNullBOOL:(id)inputTxt isD_FBSpace:(BOOL)isD_FBSpace;
#pragma mark 检查邮箱格式是否正确
+(BOOL)isValidateEmail:(NSString *)email;
#pragma mark 检查输入是否含有特殊字符
+(BOOL)IsIncludeSpecialCharact: (NSString *)str;
#pragma mark 检查输入是否含有空格
+(BOOL)IsIncludeSpace: (NSString *)str;

#pragma mark 压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
#pragma mark image对应UIImagView大小来按比例压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image imageView:(UIImageView*)imageView;

#pragma mark UILabel自适应大小
+(CGSize)setUILabelSizeWithLabelText:(NSString*)text font:(CGFloat)fontSize xianHeight:(CGFloat)height xianWidth:(CGFloat)width;

#pragma mark 给视图添加细线
+(void) setLineFatherView:(UIView*)view lineFrame:(CGRect)rect lineColor:(UIColor*)color;

#pragma mark 16进制颜色(html颜色值)字符串转为UIColor
+(UIColor*) colorWithHexString:(NSString*)stringToConvert;

#pragma mark 16进制颜色转换UIImage
+(UIImage*) drawcolorInImage:(NSString*)colorName;

#pragma mark -- 判断是否是手机号码
+ (BOOL)isPhoneNum:(NSString*)string;

#pragma mark --判断是否是数字
+(BOOL)isNumber:(NSString *)textString;

#pragma mark --判断数字是否有两位小数
+ (BOOL) isDigitWithTwoDecimal:(NSString *)number;

#pragma mark -- 用户名，密码
+ (BOOL) validateUsername:(NSString *)username;

+ (BOOL) validatePassword:(NSString *)passWord;

+ (BOOL) validateMobile:(NSString *)mobile;

#pragma mark - 只能输入数字、字母、中划线、斜杠
+ (BOOL) validateInputStr:(NSString *)inputWord;

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
+ (BOOL)validateInputString:(NSString *)inputString limitMinLength:(NSInteger)limitMinLength limitMaxLength:(NSInteger)limitMaxLength nType:(NSInteger)nType;

//验证中文输入长度,返回输入内容
+ (NSString*) validateChinaLimitNum:(int)maxLimitNum textField:(UITextField*)textField inputModeStr:(NSString*)inputModeStr;

#pragma mark --当前时间转成时间戳
+(NSString *)getTimeIntervalStringFromNowDate:(NSInteger)type Anddate:(NSDate *)date;
#pragma mark --时间戳转成当前时间date(Nsdate)
+(NSDate *)getDateByIntervalWithdatestr:(NSString *)datestr type:(int)type;
#pragma mark --当前时间date(Nsdate)转成时间字符串
+(NSString *)getDateStrByDate:(NSDate *)date type:(int)type;
#pragma mark --时间字符串转换成时间戳
+(NSString *)getTimeChuoWithdateStr:(NSString *)dateStr type:(int)type;
#pragma mark --时间戳转成当前时间
+(NSString *)getDateByIntervalWithTimeCuo:(NSTimeInterval)intervalTime type:(int)type;
#pragma mark --根据开始时间结束时间计算差值
+(NSTimeInterval)getTotalTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime type:(int)type;
#pragma mark --根据传入时间得出友好提示信息
+(NSString*)getFriendlyTime:(NSDate *)dateTime type:(int)type;

#pragma mark 根据宽度对图片等比压缩处理
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

#pragma mark - 给视图添加阴影
+(void)AddShadow:(UIView*)view;

#pragma mark - 随机产生的数字字符串
+ (NSString *)generatesRandNum;

#pragma mark - 产生输入框的对话框
+(UIAlertController *)setupTextAlertViewInVC:(UIViewController *)VC withTitle:(NSString *)title message:(NSString *)message withkeybords:(NSInteger)type confirmBlock:(void (^)(id count))confirm cancelBlock:(void (^)(id count))cancel;

#pragma mark 对钱数字符串进行每隔三个字符添加一逗号的处理
+(NSString *)stringAddCommaFromStr:(NSString *)numStr;
#pragma mark 判断输入为空
+(BOOL)CheckInputISNullBOOL:(id)inputTxt;
#pragma mark 空值字符串显示为nullStr
+(NSString*) getSafeStrWithStr:(id)str showNull:(NSString*)nullStr;
#pragma mark 获取当前年月日 year month day
+ (NSDictionary *) getCurrentDate;

//+(NSString *)getTimeChuoHaveHourWithdateStr:(NSString *)dateStr;

#pragma mark - UILabel文本自适应高度
+ (CGRect)adaptOriginalFrame:(CGRect)frame withStrText:(NSString *)text withFont:(UIFont *)font;

+(UIViewController*) topMostController;

#pragma mark - 根据字体大小获取文本宽度
+(CGFloat) getWidthWithFontSize:(CGFloat)fontSize textStr:(NSString*)textStr;

#pragma mark - 根据字体大小获取文本高度
+(CGFloat) getHeightWithFontSize:(CGFloat)fontSize textStr:(NSString*)textStr;

#pragma mark - 获取某年某月的天数
+(NSInteger)howManyDaysWithYear:(NSInteger)year month:(NSInteger) month;


/**
 isNullValue

 @param obj object
 @return isNull reture true else reture false
 */
BOOL isNullValue(id obj);

/**
 safeString
 @param obj object
 @return isNullValue reture ""  else reture obj
 */
NSString *safeString(id obj);
@end
