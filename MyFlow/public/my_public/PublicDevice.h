//
//  PublicDevice.h
//  dbc
//  硬件设备类，获取硬件设备信息的类
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicDevice : NSObject
/*
 desc：获取手机硬件整体信息
 @param
 return：NSString
 */
+(NSString *)getDeviceInfo;
/*
 desc：是否是itouch
 @param
 return：BOOL,YES是ipod
 */
+(BOOL)isIPod;
/*
 desc：获取手机操作系统版本号
 @param:formatType：1简版，2详细版本号
 return：NSString
 */
+(NSString *)getSystemVersion:(int)formatType;
@end
