//
//  PublicVariable.h
//  
//
//  Created by cai liang on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//判断iphone5
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height-20)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
//公共日志
#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif
//持久文件键值名称
#define ALL_FLOW            @"allFlow"
#define FIRST_DAY           @"firstDay"
#define APP_INIT            @"appInit"
#define FLOW_MONTH_DATE_3G  @"flowMonthDate3g"
#define FLOW_DAY_DTAE_3G    @"flowDayDate3g"
#define FLOW_BASE_3G        @"flowBase3g"
#define LOCATION            @"location"
#define IMAGE               @"image"
#define IMAGE_BACKGROUND    @"imageBackground"
//通知
#define NOTI_MONTH          @"notiMonth"
#define NOTI_DAY            @"notiDay"

@interface PublicVariable : NSObject

@end
