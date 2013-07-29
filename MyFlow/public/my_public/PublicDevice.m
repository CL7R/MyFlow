//
//  PublicDevice.m
//  dbc
//  硬件设备类，获取硬件设备信息的类
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PublicDevice.h"

@implementation PublicDevice
//获取硬件整体信息
+(NSString *)getDeviceInfo{
    UIDevice *mydevice = [UIDevice currentDevice];
    NSString *strDevice=[[[NSString alloc]initWithFormat:@"{\"deviceID\":\"%@\",\"deviceName\":\"%@\",\"systemName\":\"%@\",\"systemVersion\":\"%@\",\"model\":\"%@\",\"appType\":\"%d\"}",[mydevice uniqueIdentifier],[mydevice name],[mydevice systemName],[mydevice systemVersion],[mydevice model],1]autorelease];
    return strDevice;
}
//是否是itouch
+(BOOL)isIPod{
    BOOL ipodFlag=NO;
    NSString *model= [[UIDevice currentDevice] model];
    if ([model compare:@"iPod Touch" options:NSCaseInsensitiveSearch] == NSOrderedSame||[model compare:@"iPod" options:NSCaseInsensitiveSearch] == NSOrderedSame||
        [model compare:@"iPad" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        ipodFlag=YES;
    }
    return ipodFlag;
}
+(NSString *)getSystemVersion:(int)formatType{
    UIDevice *mydevice = [UIDevice currentDevice];
    NSString *strVersion=[mydevice systemVersion];
    CLog(@"\n[getSystemVersion]%@", strVersion);
    if (formatType==1) {
        strVersion=[strVersion substringToIndex:1];
    }
    return strVersion;
}
@end
