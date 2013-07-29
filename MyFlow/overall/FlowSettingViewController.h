//
//  FlowSettingViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-20.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_HELP        1
#define TAG_ALL         2
#define TAG_ALREADY     3
#define TAG_DELETE      4
#define TAG_TEX_ALL     5
#define TAG_TEX_ALREADY 6

@class BaiduMapController;
@class DataDao;
@interface FlowSettingViewController : UIViewController<UITableViewDataSource,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,assign) float allFlow;
@property (nonatomic,assign) float alreadyFlow;
@property (strong,nonatomic) BaiduMapController *mapCon;
@property (strong,nonatomic) NSDictionary *dicMore;
@property (strong,nonatomic) NSArray *arrMore;
@property (strong,nonatomic) DataDao *dao;

-(void)initView;
-(void)initData;

-(void)actionLocation:(id)sender;
@end
