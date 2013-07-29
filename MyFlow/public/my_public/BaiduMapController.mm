//
//  BaiduMapController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "BaiduMapController.h"

@interface BaiduMapController ()

@end

@implementation BaiduMapController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_mapManager release];
    [_mapView release];
    [_myLocation release];
    [super dealloc];
}
#pragma mark - init
+(BaiduMapController *)getInstance{
    static BaiduMapController *map=nil;
    if(map==nil){
        map=[[BaiduMapController alloc]init];
    }
    return map;
}
-(void)initBaiduMap{
    _mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:BAIDU_ID generalDelegate:(id)self];    
	if (!ret) {
		NSLog(@"\n[manager start failed!]");
	}
}
-(BOOL)initData{
    _mapView=[[BMKMapView alloc]init];
    _mapView.delegate=self;
    //自带定位
    NSLog(@"\n[initData-baidu]%d,%d",[CLLocationManager locationServicesEnabled],[CLLocationManager authorizationStatus]);
    if ([CLLocationManager locationServicesEnabled]&&[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
        _myLocation=[[CLLocationManager alloc]init];
        _myLocation.delegate=self;
        return YES;
    }
    else{
        return NO;
    }    
}
#pragma mark - other
-(BOOL)isOpenLocation{
    if ([CLLocationManager locationServicesEnabled]&&[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
        return YES;
    }
    else{
        return NO;
    }
}
-(BOOL)startLocation{
    if ([CLLocationManager locationServicesEnabled]&&[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
        [_myLocation startUpdatingLocation];
        _myLocation.desiredAccuracy=kCLLocationAccuracyBest;
        return YES;
    }
    else{
        return NO;
    }
    
}
-(void)closeLocation{
    [_myLocation stopUpdatingLocation];
    _myCoor.latitude=0;
    _myCoor.longitude=0;
}
-(void)startMapLocation{
    [_myLocation startUpdatingLocation];
    _myLocation.desiredAccuracy=kCLLocationAccuracyBest;
    _mapView.showsUserLocation=YES;
}
-(void)closeMapLocation{
    [_myLocation stopUpdatingLocation];
    _mapView.showsUserLocation=NO;
}
-(void)locationZoomIn{
    _myLocation.desiredAccuracy=kCLLocationAccuracyKilometer;
}
-(void)locationZoomOut{
    _myLocation.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
}
-(void)getMyLocation{
    _myCoor.latitude=[[_myLocation location] coordinate].latitude+latitudeDisplacement;
    _myCoor.longitude=[[_myLocation location] coordinate].longitude+longitudeDisplacement;
}
-(void)backMyLocation{
    [_mapView setCenterCoordinate:_myCoor animated:YES];
}
-(void)mapZoomIn{
    [_mapView zoomIn];
}
-(void)mapZoomOut{
    [_mapView zoomOut];
}
#pragma mark - baiduDelegate
//用户位置更新
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{    
    _myCoor.latitude=userLocation.location.coordinate.latitude;
    _myCoor.longitude=userLocation.location.coordinate.longitude;
    if ([_delegate respondsToSelector:@selector(updateLocation)]) {
        [_delegate updateLocation];
    }
}
//地图上添加标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mV
             viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKPinAnnotationView *pinView = nil;
    if ( pinView == nil )
    {
        pinView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
    }
    if(![annotation isKindOfClass:[BMKUserLocation class]]){
        NSLog(@"\n[viewForAnnotation]%@",annotation.title);
        pinView.pinColor = BMKPinAnnotationColorRed;  //设置指针颜色
        pinView.canShowCallout = YES;
        pinView.animatesDrop=YES;
    }
    return pinView;
}
#pragma mark locationDelegate
//用户位置更新
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    NSLog(@"\n[didUpdateToLocation-ios4]%f",newLocation.coordinate.latitude);
    _myCoor.latitude=newLocation.coordinate.latitude+latitudeDisplacement;
    _myCoor.longitude=newLocation.coordinate.longitude+longitudeDisplacement;
    if ([_delegate respondsToSelector:@selector(updateLocation)]) {
        [_delegate updateLocation];
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"\n[didUpdateToLocation-ios6]");
    _myCoor.latitude=manager.location.coordinate.latitude+latitudeDisplacement;
    _myCoor.longitude=manager.location.coordinate.longitude+longitudeDisplacement;
    if ([_delegate respondsToSelector:@selector(updateLocation)]) {
        [_delegate updateLocation];
    }
}
-(void)locationManager: (CLLocationManager *)manager didFailLoadWithError:(NSError *)error{
    NSLog(@"\n[didFailLoadWithError]");
}
@end
