//
//  DetailMapViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMapController.h"
@class DetailMapView;
@class DataDao;
@interface DetailMapViewController : UIViewController<UIAlertViewDelegate,BaiduMapDelegate>

@property (strong,nonatomic) NSString *strDay;
@property (strong,nonatomic) DetailMapView *detailMap;
@property (strong,nonatomic) BaiduMapController *mapCon;
@property (strong,nonatomic) DataDao *dao;
@property (strong,nonatomic) NSArray *arrFlowMap;

-(void)initView;
-(void)initData;
-(void)initFlowMap;

-(void)actionMyLocation:(id)sender;
-(void)actionZoomIn:(id)sender;
-(void)actionZoomOut:(id)sender;
-(void)actionDetailHelp;
@end
