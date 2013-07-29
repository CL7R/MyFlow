//
//  DetailMapView.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DetailMapView.h"
#import "BaiduMapController.h"
@implementation DetailMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

-(void)dealloc{
    [_viewOperation release];
    [_btnLocation release];
    [_viewMap release];
    [_btnMyLocation release];
    [_btnZoomIn release];
    [_btnZoomOut release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    //开启地理位置视图
    _viewOperation=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_viewOperation setBackgroundColor:colorBackground];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 70)];
    [lab setText:NSLocalizedString(@"打开实时监控可以提高准确性。\n可以查看地理位置信息。\n会消耗少许电量。", nil)];
    lab.lineBreakMode =UILineBreakModeWordWrap;
    lab.numberOfLines=3;
    [lab setBackgroundColor:[UIColor clearColor]];
    [_viewOperation addSubview:lab];
    [lab release];
    _btnLocation=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLocation retain];
    [_btnLocation setFrame:CGRectMake(20, 120, 280, 50)];
    [_btnLocation setTitle:NSLocalizedString(@"打开实时监控", nil) forState:UIControlStateNormal];
    [_btnLocation setBackgroundImage:imgSms forState:UIControlStateNormal];
    [_viewOperation addSubview:_btnLocation];
    //地图
    _viewMap=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BaiduMapController *mapCon=[BaiduMapController getInstance];
    [mapCon.mapView setFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    //当前位置
    _btnMyLocation=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnMyLocation retain];
    [_btnMyLocation setFrame:CGRectMake(10, 15, 35, 35)];
    [_btnMyLocation setBackgroundImage:imgMyLocation forState:UIControlStateNormal];
    _btnMyLocation.alpha=0.7;
    [mapCon.mapView addSubview:_btnMyLocation];
    //放大
    _btnZoomIn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnZoomIn retain];
    [_btnZoomIn setFrame:CGRectMake(275, 270, 35, 40)];
    [_btnZoomIn setBackgroundImage:imgZoomIn forState:UIControlStateNormal];
    _btnZoomIn.alpha=0.7;
    [mapCon.mapView addSubview:_btnZoomIn];
    //缩小
    _btnZoomOut=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnZoomOut retain];
    [_btnZoomOut setFrame:CGRectMake(275, 310, 35, 40)];
    [_btnZoomOut setBackgroundImage:imgZoomOut forState:UIControlStateNormal];
    _btnZoomOut.alpha=0.7;
    [mapCon.mapView addSubview:_btnZoomOut];
    [_viewMap addSubview: mapCon.mapView];
}
@end
