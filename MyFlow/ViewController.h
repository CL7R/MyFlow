//
//  ViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-22.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderViewController.h"
@interface ViewController : UIViewController


@property (strong,nonatomic) SliderViewController *slider;

-(void)initView;
@end
