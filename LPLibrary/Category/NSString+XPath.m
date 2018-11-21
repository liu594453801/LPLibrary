//
//  NSString+XPath.m
//  FinancialCloud
//
//  Created by liuzhiqiong on 15/11/18.
//  Copyright © 2015年 zpy. All rights reserved.
//

#import "NSString+XPath.h"

@implementation NSString (XPath)

+ (NSString *)pathDocuments {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)pathLibrary {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


+ (NSString *)pathTemporary {
    return NSTemporaryDirectory();
}

+ (NSString *)pathCaches {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)pathPreferences {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath
{
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return NO;
    @try
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}

//删除文件
+(BOOL)deleteFile:(NSString *)path{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        NSError *err;
        BOOL succeed = [fileManager removeItemAtPath:path error:&err];
        if (!succeed ) {
            NSLog(@"Can not delete file: %@",[err localizedDescription]);
            return NO;
        }
    }
    return YES;
}

/**
 创建文件夹

 @param path <#path description#>
 @return <#return value description#>
 */
+(BOOL)createDirectoryAtPath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        NSError *err;
        BOOL succeed = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
        if (!succeed ) {
            NSLog(@"Can not create directory: %@",[err	localizedDescription]);
            return NO;
        }
    }
    return YES;
}

@end
