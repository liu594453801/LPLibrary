//
//  UITabBar+badge.h
//  ECPlatform
//
//  Created by liuzhiqiong on 16/6/2.
//  Copyright © 2016年 北京宝润兴业科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点


@end
