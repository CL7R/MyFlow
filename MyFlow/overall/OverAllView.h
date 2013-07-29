//
//  OverAllView.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverAllView : UIView

@property (strong,nonatomic) UILabel *lab3GTitle;
@property (strong,nonatomic) UILabel *labRemain;
@property (strong,nonatomic) UILabel *btnAll;
@property (strong,nonatomic) UILabel *btnAlready;
@property (strong,nonatomic) UIImageView *imgAllBack;
@property (strong,nonatomic) UIImageView *imgAlreadyBack;
@property (strong,nonatomic) UIButton *btnSetting;
@property (strong,nonatomic) UIImageView *imgHelpInit;

-(void)initView;
@end
