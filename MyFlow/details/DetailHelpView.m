//
//  DetailHelpView.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DetailHelpView.h"

@implementation DetailHelpView

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
-(void)initView{
    [self setBackgroundColor:colorBackground];
    UIImageView *help1=[[UIImageView alloc]initWithImage:imgHelp1];
    [help1 setFrame:CGRectMake(10, 10, 140, 170)];
    [self addSubview:help1];
    UIImageView *help2=[[UIImageView alloc]initWithImage:imgHelp2];
    [help2 setFrame:CGRectMake(170, 10, 140, 170)];
    [self addSubview:help2];
    UIImageView *help3=[[UIImageView alloc]initWithImage:imgHelp3];
    [help3 setFrame:CGRectMake(10, 200, 140, 170)];
    [self addSubview:help3];
    UIImageView *help4=[[UIImageView alloc]initWithImage:imgHelp4];
    [help4 setFrame:CGRectMake(170, 200, 140, 170)];
    [self addSubview:help4];
    [help1 release];
    [help2 release];
    [help3 release];
    [help4 release];
}
@end
