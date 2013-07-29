//
//  DetailHelpViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DetailHelpViewController.h"
#import "DetailHelpView.h"

@interface DetailHelpViewController ()

@end

@implementation DetailHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initView{
    _helpView=[[DetailHelpView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_helpView];
}
@end
