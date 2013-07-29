//
//  DetailMapViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-14.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DetailMapViewController.h"
#import "DetailMapView.h"
#import "DetailHelpViewController.h"
#import "DefaultFileDataManager.h"
#import "DataDao.h"
#import "MapFlow.h"
@interface DetailMapViewController ()

@end

@implementation DetailMapViewController

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
    [_strDay release];
    [_detailMap release];
    [_arrFlowMap release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    [self.navigationItem setTitle:NSLocalizedString(@"地理位置分布", nil)];
    _detailMap=[[DetailMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT)];
    /*后台功能
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([[dicFileData objectForKey:LOCATION]intValue]==0) {
        [_detailMap addSubview:_detailMap.viewOperation];
    }
    else{
        [_detailMap addSubview:_detailMap.viewMap];
    }
     */
    [_detailMap addSubview:_detailMap.viewMap];
    [self.view addSubview:_detailMap];
    [_detailMap.btnLocation addTarget:self action:@selector(actionDetailHelp) forControlEvents:UIControlEventTouchUpInside];
    [_detailMap.btnMyLocation addTarget:self action:@selector(actionMyLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_detailMap.btnZoomIn addTarget:self action:@selector(actionZoomIn:) forControlEvents:UIControlEventTouchUpInside];
    [_detailMap.btnZoomOut addTarget:self action:@selector(actionZoomOut:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initData{
    _mapCon=[BaiduMapController getInstance];
    /*后台功能
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([[dicFileData objectForKey:LOCATION]intValue]==1) {
        _dao=[DataDao getInstance];
        NSArray *arr=[_dao queryFlowMap:_strDay flowType:FLOW_3G];
        if (arr&&[arr count]>0) {
            _arrFlowMap=arr;
            [_arrFlowMap retain];
        }
        [self initWordMap];
    }
     */
     _dao=[DataDao getInstance];
     NSArray *arr=[_dao queryFlowMap:_strDay flowType:FLOW_3G];
     if (arr&&[arr count]>0) {
     _arrFlowMap=arr;
     [_arrFlowMap retain];
     }
     [self initWordMap];
}
-(void)initWordMap{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *arrTemp=[NSArray arrayWithArray:_mapCon.mapView.annotations];
    [_mapCon.mapView removeAnnotations:arrTemp];
    CLog(@"\n[initWordMap-1]%@",_arrFlowMap);
    for(MapFlow *map in _arrFlowMap){
        double num=[map.flow doubleValue]/1024/1024;
        if (num>=0.01) {
            CLLocationCoordinate2D newCoord = {[map.latitude floatValue],[map.longitude floatValue]};
            //CLog(@"\n[initWordMap-2]%@,%@,%@,%@",map.latitude,map.longitude,map.flow,[NSString stringWithFormat:@"%.2fM",num]);
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = newCoord;
            item.title = [NSString stringWithFormat:@"%.2fM",num];
            [arr addObject:item];
            [item release];
        }
    }
    [_mapCon.mapView addAnnotations:arr];
    [arr release];
}
#pragma mark - action
-(void)actionMyLocation:(id)sender{
    [_mapCon backMyLocation];
}
-(void)actionZoomIn:(id)sender{
    [_mapCon mapZoomIn];
}
-(void)actionZoomOut:(id)sender{
    [_mapCon mapZoomOut];
}
-(void)actionDetailHelp{
    //判断是否开启定位
    if (![_mapCon isOpenLocation]) {
        CLog(@"\n[actionDetailHelp-NO]");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"定位服务未开启，您可以手动开启", nil)
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"开启", nil) otherButtonTitles:nil];
        alert.tag=1;
        [alert addButtonWithTitle:NSLocalizedString(@"取消",nil)];
        [alert show];
        [alert release];
    }
    else{
        [_mapCon startLocation];
        CLog(@"\n[actionDetailHelp-YES]");
        [DefaultFileDataManager getFileData:DATA_FILE];
        [dicFileData setObject:@"1" forKey:LOCATION];
        [DefaultFileDataManager saveFile];
        //切换到地图页面
        [UIView beginAnimations:@"view" context:nil];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [_detailMap.viewOperation removeFromSuperview];
        [_detailMap addSubview:_detailMap.viewMap];
        [UIView commitAnimations];
    }
}

#pragma mark alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        DetailHelpViewController *detailHelp=[[[DetailHelpViewController alloc]init]autorelease];
        [self.navigationController pushViewController:detailHelp animated:YES];
    }
}
@end
