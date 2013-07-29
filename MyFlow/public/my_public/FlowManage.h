//
//  FlowManage.h
//  MyFlow
//  处理流量数据
//  Created by CL7RNEC on 13-2-5.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataDao;
@interface FlowManage : NSObject

@property (strong,nonatomic) DataDao *dao;
/*
 desc:获取单例
 @parame:
 return:FlowManage
 */
+(FlowManage *)getInstance;
/*
 desc：保存流量
 @parame:
 return:
 */
-(void)saveFlow;
/*
 desc：初始化当月流量
 @parame:
 return:
 */
-(void)saveAllMonthFlow;
/*
 desc：消耗多少流量
 @parame:
 return:
 */
-(int)usedFlow;
@end
