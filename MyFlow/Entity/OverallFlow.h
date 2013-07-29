//
//  OverallFlow.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OverallFlow : NSManagedObject

@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSNumber * flow;
@property (nonatomic, retain) NSNumber * flowType;

@end
