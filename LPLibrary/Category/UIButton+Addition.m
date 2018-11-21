//
//  Addition.m
//  LuApp
//
//  Created by 刘鹏 on 2017/12/18.
//  Copyright © 2017年 skyween. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton(Addition)

+ (instancetype)cz_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;
}


+ (instancetype)cz_ButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor WithTarget:(nonnull id)target withAction:(nonnull SEL)action withCornerRadius:(CGFloat)cornerRadius{
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    [button sizeToFit];
    return button;
    
}

/**
 防止重复提交
 */
+ (void) preventRepeatSubmitWithBtn:(UIButton*)btn {
    btn.enabled = NO;
    NSLog(@"按钮开始失效");
    [self performSelector:@selector(rouseBtn:) withObject:btn afterDelay:1];
}

+(void)rouseBtn:(UIButton*)btn {
    NSLog(@"防重按钮。。。%@",btn);
    btn.enabled = YES;
    NSLog(@"按钮恢复响应");
}

@end
