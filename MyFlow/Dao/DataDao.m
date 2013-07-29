//
//  DataDao.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "DataDao.h"
#import "DBCoreDataManage.h"
#import "OverallFlow.h"
#import "DetailFlow.h"
#import "MapFlow.h"
@implementation DataDao

-(void)dealloc{
    [_context release];
    [super dealloc];
}
#pragma mark -
#pragma mark init
+(DataDao *)getInstance{
    static DataDao *dao=nil;
    if(dao==nil){
        dao=[[DataDao alloc]init];
    }
    return dao;
}
-(void)initData{

    DBCoreDataManage *dbcore=[DBCoreDataManage getInstance];
    _context=[dbcore managedObjectContext];
}
#pragma mark - query
-(NSArray *)queryMonthFlow:(NSString *)month
               flowType:(int)flowType{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"OverallFlow"
                                           inManagedObjectContext:_context];
    [request setEntity:ent];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(month == %@) AND (flowType == %d)",month,flowType];
    [request setPredicate:pred];
    //执行
    NSArray *result = [_context executeFetchRequest:request error:NULL];
    return result;
}
-(NSArray *)queryMonthDetailFlow:(NSString *)month
                        flowType:(int)flowType{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"DetailFlow"
                                           inManagedObjectContext:_context];
    [request setEntity:ent];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(month == %@) AND (flowType == %d)",month,flowType];
    [request setPredicate:pred];
    //排序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"day" ascending:NO selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *arrSort = [[NSArray alloc] initWithObjects:sort, nil];
    [request setSortDescriptors:arrSort];
    [sort release];
    [arrSort release];
    //执行
    NSArray *result = [_context executeFetchRequest:request error:NULL];
    return result;
}
-(NSArray *)queryDayFlow:(NSString *)day
                flowType:(int)flowType{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"DetailFlow"
                                           inManagedObjectContext:_context];
    [request setEntity:ent];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(day == %@) AND (flowType == %d)",day,flowType];
    [request setPredicate:pred];
    //执行
    NSArray *result = [_context executeFetchRequest:request error:NULL];
    return result;
}
-(NSArray *)queryFlowMap:(NSString *)day
                flowType:(int)flowType{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"MapFlow"
                                           inManagedObjectContext:_context];
    [request setEntity:ent];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(day == %@) AND (flowType == %d)",day,flowType];
    [request setPredicate:pred];
    //执行
    NSArray *result = [_context executeFetchRequest:request error:NULL];
    return result;
}
-(NSArray *)queryFlowMap:(NSString *)day
                    coor:(CLLocationCoordinate2D)coor
                flowType:(int)flowType{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"MapFlow"
                                           inManagedObjectContext:_context];
    [request setEntity:ent];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(day == %@) AND (flowType == %d) AND (latitude == %f) AND (longitude == %f)",day,flowType,coor.latitude,coor.longitude];
    [request setPredicate:pred];
    //执行
    NSArray *result = [_context executeFetchRequest:request error:NULL];
    return result;
}
#pragma mark - update
-(int)updateMonthFlow:(NSString *)month
            monthFlow:(double)monthFlow
             flowType:(int)flowType{    
    //先判断是否存在
    NSArray *arr=[self queryMonthFlow:month flowType:flowType];
    CLog(@"\n[updateMonthFlow-1]%f,%@",monthFlow,arr);
    if (!arr||[arr count]==0) {
        //不存在则插入
        OverallFlow *all=[NSEntityDescription insertNewObjectForEntityForName:@"OverallFlow"
                                                       inManagedObjectContext:_context];
        [all setMonth:month];
        [all setFlow:[NSNumber numberWithDouble:monthFlow]];
        [all setFlowType:[NSNumber numberWithInt:flowType]];
    }
    else{
        //存在则更新
        OverallFlow *all=(OverallFlow *)[arr objectAtIndex:0];
        [all setMonth:month];
        [all setFlow:[NSNumber numberWithDouble:monthFlow]];
        [all setFlowType:[NSNumber numberWithInt:flowType]];
    }
    NSError *error = nil;
    if ([_context save:&error]) {
        CLog(@"\n[updateMonthFlow-ok]");
        return COREDATA_SUCCES;
    }
    else{
        CLog(@"\n[updateMonthFlow-error]%@", [error localizedDescription]);
        return COREDATA_ERROR;
    }
}
-(int)updateDayFlow:(NSString *)day
            dayFlow:(double)dayFlow
           flowType:(int)flowType{
    //先判断是否存在
    NSArray *arr=[self queryDayFlow:day flowType:flowType];
    if (!arr||[arr count]==0) {
        CLog(@"\n[updateDayFlow-1]");
        //不存在则插入
        DetailFlow *detail=[NSEntityDescription insertNewObjectForEntityForName:@"DetailFlow"
                                                      inManagedObjectContext:_context];
        [detail setMonth:[day substringToIndex:7]];
        [detail setDay:day];
        [detail setFlow:[NSNumber numberWithDouble:dayFlow]];
        [detail setFlowType:[NSNumber numberWithInt:flowType]];
    }
    else{
        CLog(@"\n[updateDayFlow-2]");
        //存在则更新
        DetailFlow *detail=(DetailFlow *)[arr objectAtIndex:0];
        [detail setMonth:[day substringToIndex:7]];
        [detail setDay:day];
        [detail setFlow:[NSNumber numberWithDouble:dayFlow]];
        [detail setFlowType:[NSNumber numberWithInt:flowType]];
    }    
    NSError *error = nil;
    if ([_context save:&error]) {
        CLog(@"\n[updateDayFlow-ok]");
        return COREDATA_SUCCES;
    }
    else{
        CLog(@"\n[updateDayFlow-error]%@", [error localizedDescription]);
        return COREDATA_ERROR;
    }
}
-(int)updateFlowMap:(NSString *)day
            dayFlow:(double)dayFlow
               coor:(CLLocationCoordinate2D)coor
           flowType:(int)flowType{
    //经纬度只保留小数点后三位
    NSString *strLatitude=[NSString stringWithFormat:@"%.3f",coor.latitude];
    NSString *strLongitude=[NSString stringWithFormat:@"%.3f",coor.longitude];
    double latitude=[strLatitude doubleValue];
    double longitude=[strLongitude doubleValue];
    CLog(@"\n[updateFlowMap-0]%f,%f",latitude,longitude);
    coor=CLLocationCoordinate2DMake(latitude, longitude);
    //先判断是否存在
    NSArray *arr=[self queryFlowMap:day coor:coor flowType:flowType];
    CLog(@"\n[updateFlowMap-1]%@",arr);
    if (!arr||[arr count]==0) {
        CLog(@"\n[updateFlowMap-2]");
        //不存在则插入
        MapFlow *map=[NSEntityDescription insertNewObjectForEntityForName:@"MapFlow"
                                                   inManagedObjectContext:_context];
        [map setDay:day];
        [map setFlow:[NSNumber numberWithDouble:dayFlow]];
        [map setFlowType:[NSNumber numberWithInt:flowType]];
        [map setLatitude:[NSNumber numberWithFloat:coor.latitude]];
        [map setLongitude:[NSNumber numberWithFloat:coor.longitude]];
    }
    else{
        //存在则更新
        MapFlow *map=(MapFlow *)[arr objectAtIndex:0];
        [map setDay:day];
        dayFlow+=[map.flow doubleValue];
        CLog(@"\n[updateFlowMap-3]%f",dayFlow);
        [map setFlow:[NSNumber numberWithDouble:dayFlow]];
        [map setFlowType:[NSNumber numberWithInt:flowType]];
        [map setLatitude:[NSNumber numberWithFloat:coor.latitude]];
        [map setLongitude:[NSNumber numberWithFloat:coor.longitude]];
    }
    NSError *error = nil;
    if ([_context save:&error]) {
        CLog(@"\n[updateMonthFlow-ok]");
        return COREDATA_SUCCES;
    }
    else{
        CLog(@"\n[updateMonthFlow-error]%@", [error localizedDescription]);
        return COREDATA_ERROR;
    }
}
#pragma mark - delete
-(BOOL)deleteAllFLow{
    //删除文件
    DBCoreDataManage *dbcore=[DBCoreDataManage getInstance];
    [dbcore cleanDatabase];
    //新建文件
    [self initData];
    return YES;
}
@end
