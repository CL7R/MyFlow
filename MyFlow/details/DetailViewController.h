//
//  DetailViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
@class DetailView;
@class DataDao;
@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CPTPlotDataSource>

@property (nonatomic,assign) int avgFlow;
@property (strong,nonatomic) DetailView *detailView;
@property (strong,nonatomic) NSMutableArray *arrFlow;
@property (strong,nonatomic) NSMutableArray *arrFlowTable;
@property (strong,nonatomic) DataDao *dao;

-(void)initData;
-(void)initView;
-(void)initCorePlotView;
@end
