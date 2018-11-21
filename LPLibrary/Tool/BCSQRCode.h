//
//  BCSQRCode.h
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/7/17.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface BCSQRCode : NSObject

+ (CIImage *)createQRCodeImage:(NSString *)source;

+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size;

+ (UIImage *)specialColorImage:(UIImage*)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;

+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale;



@end
