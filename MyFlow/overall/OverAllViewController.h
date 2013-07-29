//
//  OverAllViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OverAllView;
@class DataDao;
@class DefaultFileDataManager;
@interface OverAllViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic,assign) float allFlow;
@property (nonatomic,assign) float alreadyFlow;
@property (nonatomic,assign) float remainFlow;
@property (nonatomic,assign) float percent;
@property (strong,nonatomic) OverAllView *allView;
@property (strong,nonatomic) DataDao *dao;

-(void)initData;
-(void)initView;
/*
 desc:点击键盘返回键
 @parame
 return:
 */
-(void)actionKeyboardReturn:(id)sender;
/*
 desc:弹出修改总流量框
 @parame:
 return:
 */
-(void)actionAllFlow;
/*
 desc:弹出修改已用流量框
 @parame:
 return:
 */
-(void)actionAlreadyFlow;
/*
 desc:流量设置
 @parame:
 return:
 */
-(void)actionSetting;
@end
