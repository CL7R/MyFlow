//
//  AppDelegate.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-22.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#define FLURRY_KEY @"P58CMCW7NHWHP6QD3759"

#import <UIKit/UIKit.h>
#import "BaiduMapController.h"
@class ViewController;
@class FlowManage;
@class DBCoreDataManage;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BaiduMapDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) FlowManage *flow;
@property (strong, nonatomic) DBCoreDataManage *db;
@property (strong, nonatomic) BaiduMapController *baidu;
@property (strong, nonatomic) NSTimer *timer;

-(void)initData;
-(void)saveFlowMap;
@end
