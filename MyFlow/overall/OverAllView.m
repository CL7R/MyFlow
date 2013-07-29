//
//  OverAllView.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "OverAllView.h"
#import <QuartzCore/QuartzCore.h>

@implementation OverAllView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc{
    [_lab3GTitle release];
    [_labRemain release];
    [_btnAll release];
    [_btnAlready release];
    [_imgAllBack release];
    [_imgAlreadyBack release];
    [_btnSetting release];
    [_imgHelpInit release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    [self setBackgroundColor:colorBackground];
    //流量标题
    _lab3GTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    [_lab3GTitle setText:NSLocalizedString(@"2G\\3G:", nil)];
    [_lab3GTitle setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_lab3GTitle];
    //总流量
    _btnAll=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 180, 30)];
    [_btnAll retain];
    [_btnAll setFont:[UIFont systemFontOfSize:15]];
    [_btnAll setText:NSLocalizedString(@"", nil) ];
    [_btnAll setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_btnAll];
    //背景
    _imgAllBack=[[UIImageView alloc]initWithImage:imgBackground];
    [_imgAllBack setUserInteractionEnabled:YES];
    [_imgAllBack setClipsToBounds:YES];
    [_imgAllBack setFrame:CGRectMake(10, 35, 300, SCREEN_HEIGHT-120)];
    [_imgAllBack.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [_imgAllBack.layer setBorderWidth:3.0];
    [_imgAllBack.layer setMasksToBounds:YES];
    [_imgAllBack setClipsToBounds:YES];
    [self addSubview:_imgAllBack];
    //已使用背景
    _imgAlreadyBack=[[UIImageView alloc]initWithImage:imgAlready1];
    [_imgAlreadyBack setAlpha:0.80];
    [_imgAlreadyBack setUserInteractionEnabled:YES];
    [_imgAlreadyBack setClipsToBounds:YES];
    [_imgAlreadyBack setFrame:CGRectMake(0, SCREEN_HEIGHT-60, 300, 0)];
    [_imgAllBack addSubview:_imgAlreadyBack];
    //剩余流量
    _labRemain=[[UILabel alloc]initWithFrame:CGRectMake(90, 60, 180, 30)];
    [_labRemain setFont:[UIFont systemFontOfSize:15]];
    [_labRemain setText:NSLocalizedString(@"", nil)];
    [_labRemain setBackgroundColor:[UIColor clearColor]];
    [_imgAllBack addSubview:_labRemain];
    //已用流量
    _btnAlready=[[UILabel alloc]initWithFrame:CGRectMake(100, SCREEN_HEIGHT-80, 180, 30)];
    [_btnAlready retain];
    [_btnAlready setFont:[UIFont systemFontOfSize:15]];
    [_btnAlready setText:NSLocalizedString(@"", nil)];
    [_btnAlready setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_btnAlready];
    //设置
    _btnSetting=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSetting retain];
    [_btnSetting setFrame:CGRectMake(0, 0, 25, 25)];
    [_btnSetting setBackgroundImage:imgSetting forState:UIControlStateNormal];
    //初始化帮助
    _imgHelpInit=[[UIImageView alloc]initWithImage:imgHelpInit];
    [_imgHelpInit setFrame:CGRectMake(200, 10, 100, 200)];
}
@end
