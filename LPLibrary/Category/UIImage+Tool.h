//
//  UIImage+Tool.h
//  FinancialCloud
//
//  Created by ZpyZp on 15/11/12.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

/**
 *  生成一个带圆环的图片
 *
 *  @param name   图片的名称
 *  @param border 圆环的宽度
 *  @param color  圆环的颜色
 *
 */
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 */
+ (instancetype)imageWithCaptureView:(UIView *)view;

#pragma mark 压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
#pragma mark image对应UIImagView大小来按比例压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image imageView:(UIImageView*)imageView;
#pragma mark 16进制颜色转换UIImage
+(UIImage*) drawcolorInImage:(NSString*)colorName;

/**
旋转图片--目的解决拍照图片旋转问题
 */
+(UIImage *)rotateImage:(UIImage *)aImage;

+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

@end

