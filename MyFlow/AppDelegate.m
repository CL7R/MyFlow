//
//  AppDelegate.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-22.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DefaultFileDataManager.h"
#import "FlowCalculate.h"
#import "FlowManage.h"
#import "DBCoreDataManage.h"
#import "DataDao.h"
#import "Flurry.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initData];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    //如果不存在当月，初始化当月所有日期数据
    [_flow saveAllMonthFlow];
    //记录流量
    [_flow saveFlow];
    /*后台功能
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([[dicFileData objectForKey:LOCATION]intValue]==1) {
        //开启定时
        CLog(@"\n[applicationWillResignActive]");
        _timer=[NSTimer scheduledTimerWithTimeInterval:1800
                                                target:self
                                              selector:@selector(saveFlowMap)
                                              userInfo:nil
                                               repeats:YES];
    }
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //如果不存在当月，初始化当月所有日期数据
    [_flow saveAllMonthFlow];
    //记录流量
    [_flow saveFlow];
    /*后台功能
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([[dicFileData objectForKey:LOCATION]intValue]==1) {
        //关闭定时
        CLog(@"\n[applicationWillEnterForeground]");
        [_timer invalidate];
    }
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //记录流量
    [_flow saveFlow];
    [_db saveContext];
}

-(void)initData{
    //初始化flurry
    [Flurry startSession:FLURRY_KEY];
    //应用是否是第一次使用
    [DefaultFileDataManager getFileData:DATA_FILE];
    if (![dicFileData objectForKey:APP_INIT]) {
        [dicFileData setObject:@"0" forKey:APP_INIT];       //应用初始化
        [dicFileData setObject:@"500" forKey:ALL_FLOW];     //每月总流量
        [dicFileData setObject:@"1" forKey:FIRST_DAY];      //结算日
        [dicFileData setObject:@" " forKey:FLOW_BASE_3G];
        [dicFileData setObject:@" " forKey:FLOW_DAY_DTAE_3G];
        [dicFileData setObject:@" " forKey:FLOW_MONTH_DATE_3G];
        [dicFileData setObject:@"0" forKey:LOCATION];       //是否开启后台记录
        [dicFileData setObject:@"0" forKey:IMAGE];          //背景图片
        [DefaultFileDataManager saveFile];
        [_baidu startLocation];
    }
    //样式
    [PublicStyle initStyle:1];
    //地图初始化
    _baidu=[BaiduMapController getInstance];
    _baidu.delegate=self;
    [_baidu initBaiduMap];
    [_baidu initData];
    [DefaultFileDataManager getFileData:DATA_FILE];
    /*后台功能
    //是否开启定位
    if ([[dicFileData objectForKey:LOCATION]intValue]==1) {
        [_baidu startLocation];
    }
     */
    [_baidu startLocation];
    CLog(@"\n[initData-app]%f",_baidu.myCoor.latitude);
    //流量管理
    _flow=[FlowManage getInstance];
    //初始化coreData
    _db=[DBCoreDataManage getInstance];
    DataDao *data=[DataDao getInstance];
    [data initData];
    //如果不存在当月，初始化当月所有日期数据
    [_flow saveAllMonthFlow];
    //记录流量
    [_flow saveFlow];
}
-(void)saveFlowMap{
    CLog(@"\n[saveFlowMap]");
    //使用流量超过1M才记录
    if ([_flow usedFlow]>0) {
        [_flow saveFlow];
    }
}
#pragma mark baiduDelegate
-(void)updateLocation{
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([[dicFileData objectForKey:LOCATION]intValue]!=1) {
        [dicFileData setObject:@"1" forKey:LOCATION];
        [DefaultFileDataManager saveFile];
    }
}
@end
