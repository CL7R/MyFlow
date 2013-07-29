//
//  FlowCalculate.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-27.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>
#import <Foundation/Foundation.h>

//定义流量变量
uint32_t iBytes3G;      //3G接收字节
uint32_t oBytes3G;      //3G发送字节
uint32_t iBytesWifi;    //WIFI接收字节
uint32_t oBytesWifi;    //WIFI发送字节
uint32_t iBytesOther;   //其他接收字节
uint32_t oBytesOther;   //其他发送字节
@interface FlowCalculate : NSObject

/*
 desc:获取网络流量信息
 @parame:
 return:
 */
+(void)getNetworkBytes;

@end