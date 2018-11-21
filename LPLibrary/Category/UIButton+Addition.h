//
//  Addition.h
//  LuApp
//
//  Created by 刘鹏 on 2017/12/18.
//  Copyright © 2017年 刘鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIButton(Addition)

/// 创建文本按钮
///
/// @param title         文本
/// @param fontSize      字体大小
/// @param normalColor   默认颜色
/// @param selectedColor 选中颜色
///
/// @return UIButton
+ (instancetype)cz_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;


/**
  定制按钮

 @param title 按钮标题
 @param Size 按钮大小
 @param backgroundColor 背景颜色
 @param target 点击事件的对象
 @param action 点击事件的方法
 @param cornerRadius 切圆角的度
 @return 按钮
 */
+ (instancetype)cz_ButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor WithTarget:(nonnull id)target withAction:(nonnull SEL)action withCornerRadius:(CGFloat)cornerRadius;

/**
 防止重复提交

 @param btn 按钮
 */
+ (void) preventRepeatSubmitWithBtn:(UIButton*)btn;

@end
