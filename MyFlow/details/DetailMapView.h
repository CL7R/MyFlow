//
//  DetailMapView.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DetailMapView : UIView

@property (strong,nonatomic) UIView *viewOperation;
@property (strong,nonatomic) UIButton *btnLocation;
@property (strong,nonatomic) UIView *viewMap;
@property (strong,nonatomic) UIButton *btnMyLocation;
@property (strong,nonatomic) UIButton *btnZoomIn;
@property (strong,nonatomic) UIButton *btnZoomOut;

-(void)initView;
@end
