//
//  ViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-22.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "ViewController.h"
#import "OverAllViewController.h"
#import "DetailViewController.h"
#import "MoreViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self initView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initView{
    NSMutableArray *arrviewControllers = [[NSMutableArray alloc]init];
    //添加视图
    OverAllViewController *overAll=[[OverAllViewController alloc]init];
    UINavigationController *navAll=[[UINavigationController alloc]initWithRootViewController:overAll];
    [arrviewControllers addObject:navAll];
    DetailViewController *detail=[[DetailViewController alloc]init];
    UINavigationController *navDetail=[[UINavigationController alloc]initWithRootViewController:detail];
    [arrviewControllers addObject:navDetail];
    MoreViewController *more=[[MoreViewController alloc]init];
    UINavigationController *navMore=[[UINavigationController alloc]initWithRootViewController:more];
    [arrviewControllers addObject:navMore];
    _slider=[[SliderViewController alloc]init];
    _slider.arrViewController=arrviewControllers;
    [self.view addSubview:_slider.view];
    CLog(@"\n[initView-viewController]%@",self.view);
    [overAll release];
    [detail release];
    [more release];
    [navAll release];
    [navDetail release];
    [navMore release];
    [arrviewControllers release];
}
@end
