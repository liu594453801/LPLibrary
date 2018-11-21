//
//  UILabel+Tool.h
//  BCS_EEBank
//
//  Created by hsq on 2018/7/31.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Tool)

/**
 设置富文本字体大小
 
 @param font 字体和大小
 @param range 位置
 */
- (void) setAttributedStringFont:(UIFont *) font range:(NSRange)range;

/**
 设置富文本显示颜色

 @param color 颜色
 @param range 位置
 */
- (void) setAttributedStringColor:(UIColor *)color range:(NSRange)range;

/**
 设置行间距
 
 @param lineSpacing 行间距
 */
- (void) setLineSpacing:(CGFloat)lineSpacing;

@end
