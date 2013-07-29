//
//  PublicDate.m
//  dbc
//  日期类，所有涉及到日期操作的类
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PublicDate.h"

@implementation PublicDate
+(NSDateComponents *)calculationDateTime:(NSString *)paramDateTime{
    //将字符串转化为日期类型
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //有些字符串日期会带有"."，需要去掉
    NSRange range = [paramDateTime rangeOfString:@"."];
    if (range.location<50) {
        paramDateTime=[paramDateTime substringToIndex:range.location];
    }
    NSDate *fromDate =[dateFormat dateFromString:paramDateTime];
    //获取当前日期
    NSDate* toDate = [NSDate date];
    //日期计算
    int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:fromDate  toDate:toDate  options:0];
    [dateFormat release];
    [gregorian release];
    return comps;
}
+(NSDateComponents *)calculationDateTime:(NSString *)paramDateTimeTo
                      parameDateTimeFrom:(NSString *)paramDateTimeFrom{
    //将字符串转化为日期类型
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //有些字符串日期会带有"."，需要去掉
    NSRange range = [paramDateTimeTo rangeOfString:@"."];
    if (range.location<50) {
        paramDateTimeTo=[paramDateTimeTo substringToIndex:range.location];
    }
    NSDate *toDate =[dateFormat dateFromString:paramDateTimeTo];
    range = [paramDateTimeFrom rangeOfString:@"."];
    if (range.location<50) {
        paramDateTimeFrom=[paramDateTimeFrom substringToIndex:range.location];
    }
    NSDate *fromDate =[dateFormat dateFromString:paramDateTimeFrom];
    //日期计算
    int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:fromDate  toDate:toDate  options:0];
    [dateFormat release];
    [gregorian release];
    return comps;
}
+(NSString *)dateToTime:(NSDate *)paramDate
               dateType:(int)paramType{
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    switch (paramType) {
        case 0:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case 1:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break; 
        case 2:
            [formatter setDateFormat:@"HH:mm:ss"];
            break; 
        case 3:
            [formatter setDateFormat:@"HH:mm"];
            break;
        case 4:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case 5:
            [formatter setDateFormat:@"MM-dd HH:mm"];
            break; 
        default:
            break;
    }
    return [formatter stringFromDate:paramDate];
}
+(NSDate *)TimeTodate:(NSString *)paramString
             dateType:(int)paramType{
    //有些字符串日期会带有"."，需要去掉
    NSRange range = [paramString rangeOfString:@"."];
    if (range.location<50) {
        paramString=[paramString substringToIndex:range.location];
    }
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    switch (paramType) {
        case 0:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case 1:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break; 
        case 2:
            [formatter setDateFormat:@"HH:mm:ss"];
            break; 
        case 3:
            [formatter setDateFormat:@"HH:mm"];
            break; 
        case 4:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:00"];
            break;
        default:
            break;
    }
    return [formatter dateFromString:paramString];
}
+(NSString *)getCurrentDate:(int)paramType{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    switch (paramType) {
        case 0:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case 1:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break; 
        case 2:
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
        case 3:
            [formatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    return [formatter stringFromDate:date];
}
+(NSString *)cancelMillisecond:(NSString *)paramString{
    //有些字符串日期会带有"."，需要去掉
    NSRange range = [paramString rangeOfString:@"."];
    if (range.location<50) {
        paramString=[paramString substringToIndex:range.location];
    }
    return paramString;
}
+(int)getMonthCounts:(NSString *)month{
    if ([month length]!=7) {
        return 0;
    }
    int count=0;
    int flag=[[month substringFromIndex:5]intValue];
    switch (flag) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            count=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            count=30;
            break;
        case 2:{
            int year=[[month substringToIndex:4]intValue];
            if ((year%4==0&&year%100!=0)||(year%100==0&&year%400==0)) {
                count=29;
            }
            else{
                count=28;
            }
            break;
        }
        default:
            break;
    }
    return count;
}
@end
