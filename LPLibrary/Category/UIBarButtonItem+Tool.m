//
//  UIBarButtonItem+Tool.m
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/4/10.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "UIBarButtonItem+Tool.h"

@implementation UIBarButtonItem (Tool)

/**
 *  创建item
 *
 *  @param target         调用哪个对象的方法
 *  @param action         跳用target的哪个方法
 *  @param Image          图片
 *  @param highlightImage 高亮图
 *
 *  @return 返回UIBarButtonItem
 */
+(UIBarButtonItem *)CreateItemWithTarget:(id)target ForAction:(SEL)action WithImage:(NSString *)Image WithHighlightImage :(NSString *)highlightImage;
{
//    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
////    leftView.extendRegionType = ClickExtendRegion;
//    leftView.backgroundColor = [UIColor redColor];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn sizeToFit];
    [Btn setFrame:CGRectMake(0, 0, 60, 40)];
    [Btn setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted] ;
    [Btn setBackgroundColor:[UIColor redColor]];
    [Btn addTarget:target action:action  forControlEvents:UIControlEventTouchUpInside];
    if (@available(iOS 11.0,*)) {
        [Btn setContentMode:UIViewContentModeScaleToFill];
        [Btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 5, 20)];
    }
    //设置尺寸
//    CGSize size = Btn.currentBackgroundImage.size;
//    [Btn setFrame:CGRectMake(-10, 0, size.width, size.height)];
//    Btn.size = Btn.currentBackgroundImage.size;
    
//    [leftView addSubview:Btn];
    
    //注：一个控件出不来两个原因：1.没设置尺寸，2.没设置图片
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
}

@end
