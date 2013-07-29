//
//  DetailViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "DataDao.h"
#import "PublicDate.h"
#import "DetailFlow.h"
#import "DefaultFileDataManager.h"
#import "DetailMapViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

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
    [_detailView release];
    [_arrFlow release];
    [_arrFlowTable release];
    [super dealloc];
}
#pragma mark - init
-(void)initData{
    NSString *str=[[PublicDate getCurrentDate:1]substringToIndex:7];
    _arrFlow=[[NSMutableArray alloc]init];
    _arrFlowTable=[[NSMutableArray alloc]init];
    _dao=[DataDao getInstance];
    //求平均流量
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([dicFileData objectForKey:ALL_FLOW]) {
        _avgFlow=[[dicFileData objectForKey:ALL_FLOW]intValue]/[PublicDate getMonthCounts:[dicFileData objectForKey:FLOW_MONTH_DATE_3G]];
    }
    CLog(@"\n[initData-detail-1]%d",_avgFlow);
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTI_DAY
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notif)
     {
         [_arrFlow removeAllObjects];
         [_arrFlowTable removeAllObjects];
         NSArray *arr=[_dao queryMonthDetailFlow:str flowType:FLOW_3G];
         for (DetailFlow *detail in arr) {
             double num=[detail.flow doubleValue]/1024/1024;
             NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:num],@"flow",detail.day,@"day", nil];
             [_arrFlow addObject:dic];
             //只保存当前天以前的数据
             int numCurrDay=[[[PublicDate getCurrentDate:1] substringFromIndex:8]intValue];
             int numDay=[[[dic objectForKey:@"day"] substringFromIndex:8]intValue];
             if (numCurrDay>=numDay) {
                 [_arrFlowTable addObject:dic];
             }
         }
         CLog(@"\n[initData-detail-2]%@",_arrFlow);
         if ([_arrFlow count]>0) {
             [self initCorePlotView];
             [_detailView.tableView reloadData];             
         }
     }
    ];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DAY object:nil];
}
-(void)initView{
    [self.navigationItem setTitle:NSLocalizedString(@"流量详单", nil)];
    [self.navigationController.navigationBar setTintColor:colorNavBar];
    _detailView=[[DetailView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_detailView];
    _detailView.tableView.delegate=self;
    _detailView.tableView.dataSource=self;
    //设置数据源代理
    _detailView.dataSourceLinePlot.dataSource = self;
}
-(void)initCorePlotView{
    //设置x,y坐标范围
    int numMax=0;
    for (NSDictionary *dic in _arrFlow) {
        if (numMax<[[dic objectForKey:@"flow"]intValue]) {
            numMax=[[dic objectForKey:@"flow"]intValue]+2;
        }
    }
    if (numMax==0) {
        numMax=1;
    }
    int numDayMax=[[[[_arrFlow objectAtIndex:0]objectForKey:@"day"] substringFromIndex:8] intValue];
    int numDayMin=[[[[_arrFlow objectAtIndex:[_arrFlow count]-1]objectForKey:@"day"] substringFromIndex:8] intValue];
    CLog(@"\n[initCorePlotView]%d,%d,%d,%d",numMax,numDayMax,numDayMin,_avgFlow);
    CPTXYPlotSpace *plotSpace =(CPTXYPlotSpace *)_detailView.graph.defaultPlotSpace;
    plotSpace.xRange =[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(numDayMin)
                                                   length:CPTDecimalFromInt([_arrFlow count])];
    plotSpace.yRange =[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0)
                                                   length:CPTDecimalFromInt(numMax)];
    //主刻度轴
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];  //设置网格
    majorGridLineStyle.lineWidth = 0.5f;
    majorGridLineStyle.lineColor = [[CPTColor grayColor] colorWithAlphaComponent:0.75];    
    /*
    //子刻度轴
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 1;
    minorGridLineStyle.lineColor = [[CPTColor blueColor] colorWithAlphaComponent:0.25];
     */
    NSNumberFormatter *labelFormatter=[[NSNumberFormatter alloc]init];  //设置刻度无小数点
	labelFormatter.numberStyle = NSNumberFormatterNoStyle;
    CPTXYAxisSet*axisSet = (CPTXYAxisSet *)_detailView.graph.axisSet;   //获取图纸对象的坐标系
    CPTXYAxis *x=axisSet.xAxis;                                         //获取坐标系的x轴坐标
    x.majorTickLineStyle = nil;                                         //去掉刻度线源头
    x.minorTickLineStyle = nil ;
    x.majorIntervalLength=CPTDecimalFromInt(5);                         //设置大刻度线的间隔单位
    x.orthogonalCoordinateDecimal= CPTDecimalFromInt(0);                //设置x坐标的原点（y轴的起点）
    x.majorGridLineStyle = majorGridLineStyle;
    //x.minorGridLineStyle = minorGridLineStyle;
	x.labelFormatter = labelFormatter;
    /*
    x.title=NSLocalizedString(@"天", nil);
    x.titleOffset=7.0f;
    x.titleLocation=CPTDecimalFromString(@"1");
    */
    CPTXYAxis *y=axisSet.yAxis;
    //设置y轴间隔值
    int numInterval=numMax/5;
    if (numInterval==0) {
        numInterval=1;
    }
    y.majorIntervalLength=CPTDecimalFromInt(numInterval);
    y.orthogonalCoordinateDecimal= CPTDecimalFromInt(numDayMin);
    y.majorGridLineStyle = majorGridLineStyle;
    y.majorTickLineStyle = nil;     //去掉刻度线源头
    y.minorTickLineStyle = nil;
    //y.minorGridLineStyle = minorGridLineStyle;
    y.labelFormatter = labelFormatter;
    y.title=NSLocalizedString(@"流量(MB)", nil);
    y.titleOffset=22.0f;
    //y.titleLocation=CPTDecimalFromString(@"20");
    [labelFormatter release];
    [_detailView.graph reloadData];
}
#pragma mark - Table view data source
//每个分区的数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrFlowTable count];
}
//每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TABLE_CELL_HEIGH;
}
//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
        [_detailView initTableCellView:cell];
    }
    int row=[indexPath row];
    UILabel *labDay=(UILabel *)[cell viewWithTag:TAG_CELL_DAY];
    [labDay setText:[[_arrFlowTable objectAtIndex:row] objectForKey:@"day"]];    
    UILabel *labFlow=(UILabel *)[cell viewWithTag:TAG_CELL_FLOW];
    double num=[[[_arrFlowTable objectAtIndex:row] objectForKey:@"flow"]doubleValue];
    if (_avgFlow<num) {
        [labFlow setTextColor:[UIColor redColor]];
    }
    else{
        [labFlow setTextColor:[UIColor blackColor]];
    }
    [labFlow setText:[NSString stringWithFormat:@"%.2f MB",num]];
    return cell;
}
#pragma mark - tableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=[indexPath row];
    DetailMapViewController *detailMap=[[[DetailMapViewController alloc]init]autorelease];
    detailMap.strDay=[[_arrFlowTable objectAtIndex:row] objectForKey:@"day"];
    [self.navigationController pushViewController:detailMap animated:YES];
}
#pragma mark - plotDataSource
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [_arrFlow count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSNumber *num=nil;
    if (fieldEnum==CPTScatterPlotFieldX) {
        num=[NSNumber numberWithInt:[[[[_arrFlow objectAtIndex:index]objectForKey:@"day"] substringFromIndex:8]intValue]];
    }
    else{
        num = [[_arrFlow objectAtIndex:index] valueForKey:@"flow"];
    }    
    return num;
}
@end
