//
//  FlowManage.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-5.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "FlowManage.h"
#import "FlowCalculate.h"
#import "PublicDate.h"
#import "DefaultFileDataManager.h"
#import "DataDao.h"
#import "OverallFlow.h"
#import "DetailFlow.h"
#import "BaiduMapController.h"
@implementation FlowManage

-(void)dealloc{
    [_dao release];
    [super dealloc];
}
#pragma mark - init
+(FlowManage *)getInstance{
    static FlowManage *flow=nil;
    if(flow==nil){
        flow=[[FlowManage alloc]init];
    }
    return flow;
}
#pragma mark - other
-(void)saveFlow{
    @synchronized(self){
        //通过底层获取流量
        [FlowCalculate getNetworkBytes];
        double flow3G=iBytes3G+oBytes3G;
        double flowMonth=0;
        double flowDay=0;
        double flowDayMap=0;
        NSString *strMonth=[[PublicDate getCurrentDate:1] substringToIndex:7];
        NSString *strDay=[PublicDate getCurrentDate:1];
        _dao=[DataDao getInstance];
        //流量如果为0不做操作
        if (flow3G==0) {
            return;
        }
        //通过文件查看是否有当月流量
        [DefaultFileDataManager getFileData:DATA_FILE];
        if (flow3G<[[dicFileData objectForKey:FLOW_BASE_3G]doubleValue]) {
            [dicFileData setObject:[NSNumber numberWithDouble:flow3G] forKey:FLOW_BASE_3G];
        }
        //如果存在当前月
        CLog(@"\n[saveMonthFlow-1]%@,%@",[dicFileData objectForKey:FLOW_MONTH_DATE_3G],strMonth);
        if ([[dicFileData objectForKey:FLOW_MONTH_DATE_3G] isEqualToString:strMonth]) {
            //叠加流量-月
            flowMonth=flow3G-[[dicFileData objectForKey:FLOW_BASE_3G]doubleValue];
            NSArray *arr=[_dao queryMonthFlow:strMonth flowType:FLOW_3G];
            if (arr&&[arr count]!=0) {
                OverallFlow *all=[arr objectAtIndex:0];
                //当月流量
                flowMonth+=[all.flow doubleValue];
                CLog(@"\n[saveMonthFlow-2]%f,%@,%f",flow3G,[dicFileData objectForKey:FLOW_BASE_3G],[all.flow doubleValue]);
            }
            //叠加流量-日
            NSArray *arrDay=[_dao queryDayFlow:strDay flowType:FLOW_3G];
            if (arrDay&&[arrDay count]!=0) {
                //叠加流量
                flowDay=flow3G-[[dicFileData objectForKey:FLOW_BASE_3G]doubleValue];
                flowDayMap=flow3G-[[dicFileData objectForKey:FLOW_BASE_3G]doubleValue];
                DetailFlow *day=[arrDay objectAtIndex:0];
                flowDay+=[day.flow doubleValue];
                CLog(@"\n[saveMonthFlow-3]%f,%f",[day.flow doubleValue],flowDay);
            }
        }
        else{
            //从0开始
            flowMonth=0;
            flowDay=0;
        }
        if (flowMonth>=0) {
            [dicFileData setObject:[NSNumber numberWithDouble:flow3G] forKey:FLOW_BASE_3G];
            [dicFileData setObject:strMonth forKey:FLOW_MONTH_DATE_3G];
            [DefaultFileDataManager saveFile];
            //保存到coreData
            //月
            [_dao updateMonthFlow:strMonth monthFlow:flowMonth flowType:FLOW_3G];
            //日
            if (flowDay>0) {
                [_dao updateDayFlow:strDay dayFlow:flowDay flowType:FLOW_3G];
                //地理位置信息
                BaiduMapController *mapCon=[BaiduMapController getInstance];
                CLog(@"\n[saveMonthFlow-4]%d",[mapCon isOpenLocation]);
                if ([mapCon isOpenLocation]) {
                    [_dao updateFlowMap:strDay dayFlow:flowDayMap coor:mapCon.myCoor flowType:FLOW_3G];
                }
            }
        }        
        //通知改变UI
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DAY object:nil];
    }
}
-(void)saveAllMonthFlow{
    _dao=[DataDao getInstance];
    NSString *strMonth=[[PublicDate getCurrentDate:1] substringToIndex:7];
    //通过文件查看是否有当月流量
    [DefaultFileDataManager getFileData:DATA_FILE];
    //如果存在当前月
    CLog(@"\n[saveAllMonthFlow-1]%@,%@",[dicFileData objectForKey:FLOW_MONTH_DATE_3G],strMonth);
    if (![[dicFileData objectForKey:FLOW_MONTH_DATE_3G] isEqualToString:strMonth]) {
        int count=[PublicDate getMonthCounts:strMonth];
        for (int i=1; i<=count; i++) {
            NSString *strDay=i<10?[NSString stringWithFormat:@"0%d",i]:[NSString stringWithFormat:@"%d",i];
            NSString *str=[NSString stringWithFormat:@"%@-%@",strMonth,strDay];
            [_dao updateDayFlow:str dayFlow:0 flowType:FLOW_3G];
            //CLog(@"\n[saveAllMonthFlow-2]%@",str);
        }
    }
}
-(int)usedFlow{
    [FlowCalculate getNetworkBytes];
    [DefaultFileDataManager getFileData:DATA_FILE];
    int flow3G=(iBytes3G+oBytes3G-[[dicFileData objectForKey:FLOW_BASE_3G]doubleValue])/1024/1024;
    return flow3G;
}
@end
