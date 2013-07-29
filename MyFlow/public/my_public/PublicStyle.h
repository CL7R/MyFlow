//
//  PublicStyle.h
//  
//  样式类，图片、颜色、大小等
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

typedef enum{
    STYLE_1=1,
    STYLE_2,
    STYLE_3
}style;
//整体
UIColor *colorBackground;
UIColor *colorNavBar;
//总体流量
UIImage *imgHelpInit;
UIImage *imgBackground;
UIImage *imgAlready1;
UIImage *imgAlready2;
UIImage *imgAlready3;
UIImage *imgSetting;
UIImage *imgSms;
//详单
UIImage *imgLine;
UIImage *imgTable;
UIImage *imgTitle;
UIImage *imgLocation;
UIImage *imgMyLocation;
UIImage *imgZoomIn;
UIImage *imgZoomOut;
UIImage *imgHelp1;
UIImage *imgHelp2;
UIImage *imgHelp3;
UIImage *imgHelp4;
UIColor *colorLine;
UIColor *colorSymbol;
//更多
@interface PublicStyle : NSObject
+(void)initStyle:(int)styleFlag;    //初始化样式
@end
