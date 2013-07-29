//
//  PublicStyle.m
//  dbc
//  涉及到
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PublicStyle.h"

@implementation PublicStyle
//初始化样式
+(void)initStyle:(int)styleFlag{
    if (styleFlag==STYLE_1) {
        //整体
        colorBackground=RGB(217, 226, 231);
        [colorBackground retain];
        colorNavBar=RGB(52, 126, 223);
        [colorNavBar retain];
        //总体
        imgHelpInit=[UIImage imageNamed:@"helpInit"];
        [imgHelpInit retain];
        imgBackground=[UIImage imageNamed:@"allBackground"];
        [imgBackground retain];
        imgAlready1=[UIImage imageNamed:@"already1"];
        [imgAlready1 retain];
        imgAlready2=[UIImage imageNamed:@"already2"];
        [imgAlready2 retain];
        imgAlready3=[UIImage imageNamed:@"already3"];
        [imgAlready3 retain];
        imgSetting=[UIImage imageNamed:@"btnSetting"];
        [imgSetting retain];
        imgSms=[UIImage imageNamed:@"btn"];
        [imgSms retain];
        //详单
        imgLine=[UIImage imageNamed:@"lineBackground"];
        [imgLine retain];
        imgTable=[UIImage imageNamed:@"tableBackground"];
        [imgTable retain];
        imgTitle=[UIImage imageNamed:@"already1"];
        [imgTitle retain];
        imgMyLocation=[UIImage imageNamed:@"btnMyLocation"];
        [imgMyLocation retain];
        imgZoomIn=[UIImage imageNamed:@"btnZoomIn"];
        [imgZoomIn retain];
        imgZoomOut=[UIImage imageNamed:@"btnZoomOut"];
        [imgZoomOut retain];
        imgLocation=[UIImage imageNamed:@"btn"];
        [imgLocation retain];
        imgHelp1=[UIImage imageNamed:@"help1"];
        [imgHelp1 retain];
        imgHelp2=[UIImage imageNamed:@"help2"];
        [imgHelp2 retain];
        imgHelp3=[UIImage imageNamed:@"help3"];
        [imgHelp3 retain];
        imgHelp4=[UIImage imageNamed:@"help4"];
        [imgHelp4 retain];
        colorLine=[UIColor colorWithRed:0.15 green:0.85 blue:0.36 alpha:0.2];
        [colorLine retain];
        colorSymbol=[UIColor colorWithRed:0.15 green:0.85 blue:0.36 alpha:1];
        [colorSymbol retain];
    }
    else if(styleFlag==STYLE_2){
        
    }
    else{
        
    }
}
@end
