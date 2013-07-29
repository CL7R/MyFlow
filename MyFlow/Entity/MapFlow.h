//
//  MapFlow.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MapFlow : NSManagedObject

@property (nonatomic, retain) NSNumber * flow;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * flowType;

@end
