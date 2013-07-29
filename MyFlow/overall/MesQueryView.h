//
//  MesQueryView.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MesQueryView : UIView

@property (strong,nonatomic) UILabel *labOperator;
@property (strong,nonatomic) UISegmentedControl *segOperator;
@property (strong,nonatomic) UIButton *btnMes;

-(void)initView;
@end
