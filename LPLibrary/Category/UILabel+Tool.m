//
//  UILabel+Tool.m
//  BCS_EEBank
//
//  Created by hsq on 2018/7/31.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "UILabel+Tool.h"

@implementation UILabel (Tool)

/**
 设置富文本字体大小

 @param font 字体和大小
 @param range 位置
 */
- (void) setAttributedStringFont:(UIFont *) font range:(NSRange)range {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attributedString;
}

/**
 设置富文本显示颜色
 
 @param color 颜色
 @param range 位置
 */
- (void) setAttributedStringColor:(UIColor *)color range:(NSRange)range{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attributedString;
}

/**
 设置行间距

 @param lineSpacing 行间距
 */
- (void) setLineSpacing:(CGFloat)lineSpacing{
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;// - (self.font.lineHeight - self.font.pointSize);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end
