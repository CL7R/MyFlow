//
//  DetailHelpViewController.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailHelpView;
@interface DetailHelpViewController : UIViewController

@property (strong,nonatomic) DetailHelpView *helpView;

-(void)initView;
@end
