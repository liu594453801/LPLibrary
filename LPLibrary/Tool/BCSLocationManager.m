//
//  BCSLocationManager.m
//  BCS_EEBank
//
//  Created by 刘鹏 on 2018/8/13.
//  Copyright © 2018年 刘鹏. All rights reserved.
//

#import "BCSLocationManager.h"
#import "JZLocationConverter.h"
#import "PublicClass.h"

@implementation BCSLocationManager
{
    
    CLGeocoder        *_geocoder;
    CLLocationManager *_locationManager;
    NSString          *locationCityStr;  //定位到得城市信息
}

+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(void)beginLocation
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        //定位功能可用
        //        CLog(@"--------开始定位");
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [_locationManager requestAlwaysAuthorization];
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager startUpdatingLocation];
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用提示，可自行添加提示
//        ShowAlertView *showAlertView = [[ShowAlertView alloc] initWithTitle:@"提示" msgStr:@"定位服务不可用，请进入“设置-企业e钱庄-位置”设置定位服务可用。否则定位不准"  cancelTitle:@"" doneTitle:@"确定"];
//        [showAlertView show];
        
        if ([self.delegate respondsToSelector:@selector(locationCityWithIsSuccess:locationCity:error:latitude:longitude:name:)]) {
            [self.delegate locationCityWithIsSuccess:NO locationCity:@"" error:@"" latitude:0 longitude:0 name:@""];
        }
    }
}

//结束定位
-(void)endLocation
{
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
    
    
    if ([self.delegate respondsToSelector:@selector(locationCityWithIsSuccess:locationCity:error:latitude:longitude:name:)]) {
        [self.delegate locationCityWithIsSuccess:NO locationCity:@"" error:@"" latitude:0 longitude:0 name:@""];
    }
    //如果不需要实时定位，使用完即使关闭定位服务
    [self endLocation];
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    //WGS-84(国际标准坐标)
    CLLocationCoordinate2D wgsPt = newLocation.coordinate;
    //GCJ-02(中国国测局坐标(火星坐标))
//    CLLocationCoordinate2D gcjPt = [JZLocationConverter wgs84ToGcj02:wgsPt];
    //BD-09(百度坐标)
    CLLocationCoordinate2D bdPt = [JZLocationConverter wgs84ToBd09:wgsPt];
    
    if ([self.delegate respondsToSelector:@selector(locationCityWithIsSuccess:locationCity:error:latitude:longitude:name:)]) {
        [self.delegate locationCityWithIsSuccess:YES locationCity:@"" error:@"" latitude:bdPt.latitude longitude:bdPt.longitude name:@""];
    }
    //如果不需要实时定位，使用完即使关闭定位服务
    [self endLocation];

    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary);
        NSString *cityStr = placemark.addressDictionary[@"City"];
        NSString *nameStr = placemark.addressDictionary[@"Name"];
        if ([PublicClass CheckInputISNullBOOL:cityStr]) {
            locationCityStr = cityStr;
            if ([self.delegate respondsToSelector:@selector(locationCityWithIsSuccess:locationCity:error:latitude:longitude:name:)]) {
                [self.delegate locationCityWithIsSuccess:YES locationCity:locationCityStr error:@"" latitude:latitude longitude:longitude name:nameStr];
            }
            //如果不需要实时定位，使用完即使关闭定位服务
            [self endLocation];
            
        }else{
            //如果没有城市信息，则显示默认城市
            if ([self.delegate respondsToSelector:@selector(locationCityWithIsSuccess:locationCity:error:latitude:longitude:name:)]) {
                [self.delegate locationCityWithIsSuccess:YES locationCity:@"深圳市" error:@"" latitude:latitude longitude:longitude name:@"深圳市"];
            }
        }
    }];
}

@end
