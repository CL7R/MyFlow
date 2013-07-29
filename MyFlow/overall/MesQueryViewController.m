//
//  MesQueryViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "MesQueryViewController.h"
#import "MesQueryView.h"
#import "MessageSend.h"
@interface MesQueryViewController ()

@end

@implementation MesQueryViewController

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
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_mesView release];
    [_dicSms release];
    [super dealloc];
}
#pragma mark - init
-(void)initData{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"operator" ofType:@"plist"];
    _dicSms=[[NSDictionary alloc]initWithContentsOfFile:path];
    CLog(@"\n[initData-sms]%@",_dicSms);
}
-(void)initView{
    self.navigationItem.title=NSLocalizedString(@"流量查询", nil);
    _mesView=[[MesQueryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_mesView];
    [_mesView.btnMes addTarget:self action:@selector(actionMes:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - action
-(void)actionMes:(id)sender{    
    MessageSend *sms=[[[MessageSend alloc]init]autorelease];
    CLog(@"\n[actionMes]%d",_mesView.segOperator.selectedSegmentIndex);
    switch (_mesView.segOperator.selectedSegmentIndex) {
        case 0:
            sms.phoneNum=[[_dicSms objectForKey:@"联通"]objectForKey:@"num"];
            sms.message=[[_dicSms objectForKey:@"联通"]objectForKey:@"command"];
            break;
        case 1:
            sms.phoneNum=[[_dicSms objectForKey:@"电信"]objectForKey:@"num"];
            sms.message=[[_dicSms objectForKey:@"电信"]objectForKey:@"command"];
            break;
        case 2:
            sms.phoneNum=[[_dicSms objectForKey:@"移动"]objectForKey:@"num"];
            sms.message=[[_dicSms objectForKey:@"移动"]objectForKey:@"command"];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:sms animated:YES];
}
@end
