//
//  OverAllViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "OverAllViewController.h"
#import "OverAllView.h"
#import "DataDao.h"
#import "DefaultFileDataManager.h"
#import "PublicDate.h"
#import "OverallFlow.h"
#import "PublicCheck.h"
#import "TKAlertCenter.h"
#import "FlowSettingViewController.h"
#import "PublicPicture.h"
@interface OverAllViewController ()

@end

@implementation OverAllViewController

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
    [self initData];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_allView release];
    [super dealloc];
}
#pragma mark - super
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //隐藏键盘
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    CLog(@"\n[touchesBegan]%@",view);
    if ([view superview] == self.allView) {
        [DefaultFileDataManager getFileData:DATA_FILE];
        if ([[dicFileData objectForKey:APP_INIT]intValue]==0) {
            [_allView.imgHelpInit removeFromSuperview];
            [dicFileData setObject:@"1" forKey:APP_INIT];
            [DefaultFileDataManager saveFile];
        }
    }
}
#pragma mark - init
-(void)initData{
    _dao=[DataDao getInstance];
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTI_MONTH
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notif)
    {
        [DefaultFileDataManager getFileData:DATA_FILE];
        //背景是否更换
        if ([[dicFileData objectForKey:IMAGE]intValue]==1) {
            [_allView.imgAllBack setImage:[PublicPicture getImageFromLocal:IMAGE_BACKGROUND]];
        }
        else{
            [_allView.imgAllBack setImage:imgBackground];
        }
        //总流量
        _allFlow=[[dicFileData objectForKey:ALL_FLOW] floatValue];
        //已用流量
        NSString *str=[[PublicDate getCurrentDate:1] substringToIndex:7];
        
        NSArray *arr=[_dao queryMonthFlow:str flowType:FLOW_3G];
        CLog(@"\n[initData-1]%@",arr);
        if (arr&&[arr count]!=0) {
            OverallFlow *all=[arr objectAtIndex:0];
            _alreadyFlow=[all.flow floatValue]/1024/1024;
            CLog(@"\n[initData-2]%f",_alreadyFlow);
        }
        else{
            _alreadyFlow=0;
        }
        //剩余流量
        _remainFlow=_allFlow-_alreadyFlow;
        _remainFlow=_remainFlow>=0?_remainFlow:0;
        _remainFlow=_remainFlow<=_allFlow?_remainFlow:_allFlow;
        //计算流量百分比
        _percent=_alreadyFlow/_allFlow;
        _percent=_percent<=1?_percent:1;
        _percent=_percent>=0?_percent:0;
        
        CGRect rectImgAlready=_allView.imgAlreadyBack.frame;
        CGRect rectImgAll=_allView.imgAllBack.frame;
        //总流量
        [_allView.btnAll setText:[NSString stringWithFormat:@"包月流量%.2f MB",_allFlow]];
        //已使用背景
        [_allView.imgAlreadyBack setFrame:CGRectMake(rectImgAlready.origin.x,rectImgAll.size.height-rectImgAll.size.height*_percent,rectImgAlready.size.width,rectImgAll.size.height*_percent)];
        rectImgAll=_allView.imgAllBack.frame;
        rectImgAlready=_allView.imgAlreadyBack.frame;
        if (_percent<=0.6) {
            [_allView.imgAlreadyBack setImage:imgAlready1];
        }
        else if(_percent>0.6&&_percent<=0.8){
            [_allView.imgAlreadyBack setImage:imgAlready2];
        }
        else{
            [_allView.imgAlreadyBack setImage:imgAlready3];
        }
        //剩余流量
        CGRect rectLabRemain=_allView.labRemain.frame;
        [_allView.labRemain setText:_percent<=0.9?[NSString stringWithFormat:@"本月剩余%.2f MB",_remainFlow]:@""];
        [_allView.labRemain setFrame:CGRectMake(rectLabRemain.origin.x, rectImgAlready.origin.y/4, rectLabRemain.size.width, rectLabRemain.size.height)];
        //已用流量
        [_allView.btnAlready setText:[NSString stringWithFormat:@"本月已用%.2f MB",_alreadyFlow]];
    }     
     ];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
}
-(void)initView{
    [self.navigationItem setTitle:NSLocalizedString(@"我的流量", nil)];
    [self.navigationController.navigationBar setTintColor:colorNavBar];
    _allView=[[OverAllView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_allView];
    //流量设置
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:_allView.btnSetting];
    [_allView.btnSetting addTarget:self action:@selector(actionSetting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=rightBar;
    [rightBar release];
    //初始化帮助图片
    [DefaultFileDataManager getFileData:DATA_FILE];
    CLog(@"\n[dicFileData]%@",dicFileData);
    if ([[dicFileData objectForKey:APP_INIT]intValue]==0) {
        [_allView addSubview:_allView.imgHelpInit];
    }
}
#pragma mark - action
-(void)actionKeyboardReturn:(id)sender{
    
}
-(void)actionSetting{
    CLog(@"\n[actionSetting]");
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([[dicFileData objectForKey:APP_INIT]intValue]==0) {
        [_allView.imgHelpInit removeFromSuperview];
        [dicFileData setObject:@"1" forKey:APP_INIT];
        [DefaultFileDataManager saveFile];
    }
    FlowSettingViewController *setting=[[[FlowSettingViewController alloc]init]autorelease];
    setting.allFlow=_allFlow;
    setting.alreadyFlow=_alreadyFlow;
    [self.navigationController pushViewController:setting animated:YES];
}
@end
