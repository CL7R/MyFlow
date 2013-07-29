//
//  DataDao.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum{
    COREDATA_SUCCES=1,
    COREDATA_REPEAT,
    COREDATA_ERROR
}coreDataFlag;

typedef enum{
    FLOW_3G=0,
    FLOW_WIFI
}flowType;

@class OverAllView;
@class DetailFlow;
@class MapFlow;

@interface DataDao : NSObject

@property(strong,nonatomic) NSManagedObjectContext *context;
/*
 desc:获取单例
 @parame:
 return:DataDao
 */
+(DataDao *)getInstance;

-(void)initData;
/*
 desc:查询当月使用总量
 @parame:month:月份
 @parame:flowType：流量类型
 return:NSArray
 */
-(NSArray *)queryMonthFlow:(NSString *)month
              flowType:(int)flowType;
/*
 desc:查询当月使用详单
 @parame:month:月份
 @parame:flowType：流量类型
 return:NSArray
 */
-(NSArray *)queryMonthDetailFlow:(NSString *)month
                     flowType:(int)flowType;
/*
 desc:查询某日流量
 @parame:day:日期
 @parame:flowType：流量类型
 return:NSArray
 */
-(NSArray *)queryDayFlow:(NSString *)day
                flowType:(int)flowType;
/*
 desc:查询流量使用位置
 @parame:day:日期
 @parame:flowType：流量类型
 return:NSArray
 */
-(NSArray *)queryFlowMap:(NSString *)day
                     flowType:(int)flowType;
/*
 desc:查询某日同一地点使用流量
 @parame:day:日期
 @parame:coor：经纬度
 @parame:flowType：流量类型
 return:NSArray
 */
-(NSArray *)queryFlowMap:(NSString *)day
                    coor:(CLLocationCoordinate2D)coor
                flowType:(int)flowType;
/*
 desc:更新当月使用总量
 @parame:month:月份
 @parame:monthFlow:当月已用流量
 @parame:flowType：流量类型
 return:int
 */
-(int)updateMonthFlow:(NSString *)month
            monthFlow:(double)monthFlow
             flowType:(int)flowType;
/*
 desc:更新每日使用流量
 @parame:day:日期
 @parame:dayFlow:每日已用流量
 @parame:flowType：流量类型
 return:int
 */
-(int)updateDayFlow:(NSString *)day
            dayFlow:(double)dayFlow
           flowType:(int)flowType;
/*
 desc:更新每日使用流量位置
 @parame:day:日期
 @parame:dayFlow:每日已用流量
 @parame:coor：位置
 @parame:flowType：流量类型
 return:int
 */
-(int)updateFlowMap:(NSString *)day
            dayFlow:(double)dayFlow
               coor:(CLLocationCoordinate2D)coor
           flowType:(int)flowType;
/*
 desc:删除全部数据
 @parame:
 return:BOOL
 */
-(BOOL)deleteAllFLow;
@end
