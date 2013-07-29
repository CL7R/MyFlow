//
//  MesQueryViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MesQueryView;
@interface MesQueryViewController : UIViewController

@property (strong,nonatomic) MesQueryView *mesView;
@property (strong,nonatomic) NSDictionary *dicSms;

-(void)initData;
-(void)initView;

-(void)actionMes:(id)sender;
@end
