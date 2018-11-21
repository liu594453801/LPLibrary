//
//  NSString+XPath.h
//  FinancialCloud
//
//  Created by liuzhiqiong on 15/11/18.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XPath)
/*
 除了下面这些目录之外的所有文件进行增量式的备份：
 
 <Application_Home>/AppName.app
 <Application_Home>/Library/Caches
 <Application_Home>/tmp
 
 在应用程序更新过程中被保存的文件
 在删除老版本之前，将用户数据文件转移到新的应用程序目录下。
 
 <Application_Home>/Documents
 <Application_Home>/Library/Preferences
 
 */
//+ (NSString *) pathBundle;
+ (NSString *)pathDocuments;   //  少量程序需要保存的数据
+ (NSString *)pathPreferences; //  偏好设置文件

+ (NSString *)pathLibrary;
+ (NSString *)pathCaches;      //
+ (NSString *)pathTemporary;

//写入图片
+ (BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;
//删除文件
+(BOOL)deleteFile:(NSString *)path;
//创建文件夹
+(BOOL)createDirectoryAtPath:(NSString*)path;


@end
