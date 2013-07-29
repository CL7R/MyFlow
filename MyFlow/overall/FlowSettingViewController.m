//
//  FlowSettingViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-20.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "FlowSettingViewController.h"
#import "DetailHelpViewController.h"
#import "MesQueryViewController.h"
#import "DefaultFileDataManager.h"
#import "BaiduMapController.h"
#import "TKAlertCenter.h"
#import "PublicCheck.h"
#import "PublicDate.h"
#import "FlowManage.h"
#import "DataDao.h"
@interface FlowSettingViewController ()

@end

@implementation FlowSettingViewController

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
    CLog(@"\n[initData-more]");
    [self initView];
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_dicMore release];
    [_arrMore release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    [self.navigationController.navigationBar setTintColor:colorNavBar];
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [table setBackgroundColor:colorBackground];
    table.delegate=(id)self;
    table.dataSource=(id)self;
    [self.view addSubview:table];
    [table release];
}
-(void)initData{
    _dao=[DataDao getInstance];
    self.navigationItem.title=NSLocalizedString(@"流量设置", nil);
    NSString *path=[[NSBundle mainBundle]pathForResource:@"setting" ofType:@"plist"];
    _dicMore=[[NSDictionary alloc]initWithContentsOfFile:path];
    _arrMore=[[_dicMore allKeys]sortedArrayUsingSelector:@selector(compare:)];
    [_arrMore retain];
    _mapCon=[BaiduMapController getInstance];
}
#pragma mark - action
-(void)actionLocation:(id)sender{
    UISwitch *swit=(UISwitch *)sender;
    //开启实时
    if (swit.on==YES) {        
        if (![_mapCon isOpenLocation]) {
            [swit setOn:NO];
            CLog(@"\n[actionLocation]");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"定位服务未开启，您可以手动开启", nil)
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"开启", nil) otherButtonTitles:nil];
            alert.tag=TAG_HELP;
            [alert addButtonWithTitle:NSLocalizedString(@"取消",nil)];
            [alert show];
            [alert release];
        }
        else{
            [_mapCon startLocation];
            [DefaultFileDataManager getFileData:DATA_FILE];
            [dicFileData setObject:@"1" forKey:LOCATION];
            [DefaultFileDataManager saveFile];
        }
    }
    else{
        [DefaultFileDataManager getFileData:DATA_FILE];
        [dicFileData setObject:@"0" forKey:LOCATION];
        [DefaultFileDataManager saveFile];
        [_mapCon closeLocation];
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrMore count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key=[_arrMore objectAtIndex:section];
    NSArray *arr=[_dicMore objectForKey:key];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSUInteger section=[indexPath section];
        NSUInteger row=[indexPath row];
        NSString *key=[_arrMore objectAtIndex:section];
        NSArray *arr=[_dicMore objectForKey:key];
    
        //增加默认启动键盘设置
        cell.textLabel.text=[arr objectAtIndex:row];
        if ([[arr objectAtIndex:row]isEqualToString:@"实时监控"]) {
            UISwitch *swit=[[UISwitch alloc]initWithFrame:CGRectMake(200, 8, 80, 30)];
            [swit addTarget:self action:@selector(actionLocation:) forControlEvents:UIControlEventValueChanged];
            //是否开启实时监控
            [DefaultFileDataManager getFileData:DATA_FILE];
            CLog(@"\n[tableView-setting]%d",[[dicFileData objectForKey:LOCATION]intValue]);
            if ([[dicFileData objectForKey:LOCATION]intValue]==1) {
                [swit setOn:YES];
            }
            else{
                [swit setOn:NO];
            }
            [cell.contentView addSubview:swit];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section=[indexPath section];
    NSUInteger row=[indexPath row];
    NSString *key=[_arrMore objectAtIndex:section];
    NSArray *arr=[_dicMore objectForKey:key];
    if ([[arr objectAtIndex:row]isEqualToString:@"包月流量"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"包月流量（MB）", nil)
                                                        message:@"\n"
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"保存", nil) otherButtonTitles:nil];
        alert.tag=TAG_ALL;
        [alert addButtonWithTitle:NSLocalizedString(@"取消",nil)];
        UITextField *texCateName=[[UITextField alloc]initWithFrame:CGRectMake(alert.frame.origin.x+60, alert.frame.origin.y+40, 160, 30)];
        texCateName.tag=TAG_TEX_ALL;
        texCateName.keyboardType=UIKeyboardTypeNumberPad;
        texCateName.textColor=[UIColor blackColor];
        texCateName.backgroundColor=[UIColor whiteColor];
        texCateName.text=[NSString stringWithFormat:@"%.0f",_allFlow];
        [alert addSubview:texCateName];
        [alert show];
        [alert release];
    }
    else if([[arr objectAtIndex:row]isEqualToString:@"本月已用"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"本月已用（MB）", nil)
                                                        message:@"\n"
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"保存", nil) otherButtonTitles:nil];
        alert.tag=TAG_ALREADY;
        [alert addButtonWithTitle:NSLocalizedString(@"取消",nil)];
        UITextField *texCateName=[[UITextField alloc]initWithFrame:CGRectMake(alert.frame.origin.x+60, alert.frame.origin.y+40, 160, 30)];
        texCateName.tag=TAG_TEX_ALREADY;
        texCateName.keyboardType=UIKeyboardTypeNumberPad;
        texCateName.textColor=[UIColor blackColor];
        texCateName.backgroundColor=[UIColor whiteColor];
        texCateName.text=[NSString stringWithFormat:@"%.0f",_alreadyFlow];
        [alert addSubview:texCateName];
        [alert show];
        [alert release];
    }
    else if([[arr objectAtIndex:row]isEqualToString:@"流量查询"]) {
        MesQueryViewController *mes=[[[MesQueryViewController alloc]init]autorelease];
        [self.navigationController pushViewController:mes animated:YES];
    }
    else if([[arr objectAtIndex:row]isEqualToString:@"清空数据"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"清空数据", nil)
                                                        message:@"您是否要清空所有流量数据"
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil];
        alert.tag=TAG_DELETE;
        [alert addButtonWithTitle:NSLocalizedString(@"取消",nil)];
        [alert show];
        [alert release];
    }
}
#pragma mark alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if (alertView.tag==TAG_HELP) {
            DetailHelpViewController *detailHelp=[[[DetailHelpViewController alloc]init]autorelease];
            [self.navigationController pushViewController:detailHelp animated:YES];
        }
        else if (alertView.tag==TAG_ALL) {
            //数字格式校验
            UITextField *tex=(UITextField *)[alertView viewWithTag:TAG_TEX_ALL];
            if ([PublicCheck validateNumber:tex.text]&&[tex.text doubleValue]>=0) {
                [DefaultFileDataManager getFileData:DATA_FILE];
                [dicFileData setObject:tex.text forKey:ALL_FLOW];
                [DefaultFileDataManager saveFile];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
            }
            else{
                [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"请输入正确的数字", nil)];
            }
        }
        else if (alertView.tag==TAG_ALREADY) {
            //数字格式校验
            UITextField *tex=(UITextField *)[alertView viewWithTag:TAG_TEX_ALREADY];
            if ([PublicCheck validateNumber:tex.text]&&[tex.text doubleValue]>=0) {
                _alreadyFlow=[tex.text doubleValue];
                [_dao updateMonthFlow:[[PublicDate getCurrentDate:1] substringToIndex:7]
                            monthFlow:_alreadyFlow*1024*1024
                             flowType:FLOW_3G];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
            }
            else{
                [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"请输入正确的数字", nil)];
            }
        }
        else{
            [_dao deleteAllFLow];
            [DefaultFileDataManager getFileData:DATA_FILE];
            [dicFileData setObject:@"500" forKey:ALL_FLOW];     //每月总流量
            [dicFileData setObject:@"1" forKey:FIRST_DAY];      //结算日
            [dicFileData setObject:@" " forKey:FLOW_BASE_3G];
            [dicFileData setObject:@" " forKey:FLOW_DAY_DTAE_3G];
            [dicFileData setObject:@" " forKey:FLOW_MONTH_DATE_3G];
            [dicFileData setObject:@"0" forKey:IMAGE];          //背景图片
            [DefaultFileDataManager saveFile];
            //如果不存在单月，初始化当月所有日期数据
            FlowManage *flow=[FlowManage getInstance];
            [flow saveAllMonthFlow];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DAY object:nil];
        }
    }
}
@end
