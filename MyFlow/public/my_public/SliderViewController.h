//
//  SliderViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-27.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController

@property (nonatomic,assign) int selectedIndex;
@property (nonatomic,assign) CGFloat scaleFactor;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *arrViewController;

-(void)initView;
/*
 desc:添加视图及手势
 @parame:viewController：视图控制器
 @parame:index：控制器索引
 return:
 */
-(void)addViewController:(UIViewController *)viewController
                   index:(int)index;
/*
 desc:手势触发事件
 @parame:gesture：手势类型
 return:
 */
-(void)actionSwipView:(UISwipeGestureRecognizer *)gesture;

@end
