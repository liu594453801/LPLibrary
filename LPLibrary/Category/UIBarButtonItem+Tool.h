//
//  UIBarButtonItem+Tool.h
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/4/10.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Tool)
    
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

@end
