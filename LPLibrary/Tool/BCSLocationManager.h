//
//  BCSLocationManager.h
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/8/13.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@protocol T_LocationManagerDelegate <NSObject>

@optional
-(void)locationCityWithIsSuccess:(BOOL)isSuccess locationCity:(NSString*)locationCityStr error:(NSString*)errorStr latitude:(double)latitude longitude:(double)longitude name:(NSString*)nameStr;

@end

@interface BCSLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic, weak) id<T_LocationManagerDelegate> delegate;

+ (instancetype)shared;

//开始定位
-(void)beginLocation;

//结束定位
-(void)endLocation;

@end
