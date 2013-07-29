//
//  MesQueryView.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "MesQueryView.h"

@implementation MesQueryView

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
    [_labOperator release];
    [_segOperator release];
    [_btnMes release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    [self setBackgroundColor:colorBackground];
    //运营商选择
    _labOperator=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    [_labOperator setBackgroundColor:[UIColor clearColor]];
    [_labOperator setText:NSLocalizedString(@"运营商", nil)];
    [self addSubview:_labOperator];    
    NSArray *arrName = [NSArray arrayWithObjects:NSLocalizedString(@"联通", nil),NSLocalizedString(@"电信", nil),NSLocalizedString(@"移动", nil), nil];
    _segOperator=[[UISegmentedControl alloc] initWithItems:arrName];
    [_segOperator setSegmentedControlStyle:UISegmentedControlStyleBar];
    [_segOperator setTintColor:colorNavBar];
    _segOperator.frame=CGRectMake(100, 10, 150, 30);
    [_segOperator setSelectedSegmentIndex:0];
    [self addSubview:_segOperator];
    //发送短信
    _btnMes=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnMes retain];
    [_btnMes setFrame:CGRectMake(10, 70, 300, 50)];
    [_btnMes setTitle:NSLocalizedString(@"发送免费短信", nil) forState:UIControlStateNormal];
    [_btnMes setBackgroundImage:imgSms forState:UIControlStateNormal];
    [self addSubview:_btnMes];    
}
@end
