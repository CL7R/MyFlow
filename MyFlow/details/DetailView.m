//
//  DetailView.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DetailView.h"
#import <QuartzCore/QuartzCore.h>
@implementation DetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc{
    [_viewLine release];
    [_graph release];
    [_dataSourceLinePlot release];
    [_viewTable release];
    [_tableView release];
    [_labTitleDay release];
    [_labTitleFlow release];
    [_imgvTitle release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    [self setBackgroundColor:colorBackground];
    //趋势图
    _viewLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIImageView *img=[[UIImageView alloc]initWithFrame:_viewLine.bounds];
    [img setImage:imgLine];
    [_viewLine addSubview:img];
    [self addSubview:_viewLine];
    //画板
    _graph = [[CPTXYGraph alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    [_graph setBackgroundColor:[[UIColor clearColor] CGColor]];
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    hostingView.hostedGraph = _graph;
    [_viewLine addSubview:hostingView];
    [hostingView release];
    //设置四周空白
    _graph.paddingLeft = 0;
	_graph.paddingTop = 0;
	_graph.paddingRight = 0;
	_graph.paddingBottom = 0;
    _graph.plotAreaFrame.paddingLeft = 40.0 ;
    _graph.plotAreaFrame.paddingRight = 20.0 ;
    _graph.plotAreaFrame.paddingTop=10.0;
    _graph.plotAreaFrame.paddingBottom = 30.0 ;
    //设置折线
    _dataSourceLinePlot  = [[CPTScatterPlot alloc] init];
    CPTMutableLineStyle*lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0f;
    lineStyle.lineWidth = 1.0f;
    lineStyle.lineColor = [CPTColor colorWithCGColor:[colorSymbol CGColor]];
    _dataSourceLinePlot.dataLineStyle= lineStyle;
    _dataSourceLinePlot.identifier = @"Plot";
    //设置区域颜色
    CPTFill *areaGradientFill = [CPTFill fillWithColor :[CPTColor colorWithCGColor:[colorLine CGColor]]];
    _dataSourceLinePlot.areaFill = areaGradientFill;
    _dataSourceLinePlot.areaBaseValue = CPTDecimalFromString ( @"0.0" );
    _dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationLinear ;
    //设置数据元代理
    [_graph addPlot:_dataSourceLinePlot];
    //折线图上的点
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor colorWithCGColor:[colorSymbol CGColor]];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill = [CPTFill fillWithColor :[CPTColor colorWithCGColor:[colorSymbol CGColor]]];
    plotSymbol.lineStyle = symbolLineStyle;
    plotSymbol.size = CGSizeMake(3.5, 3.5);
    _dataSourceLinePlot.plotSymbol = plotSymbol;
    //列表
    _viewTable=[[UIView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT-170)];
    [self addSubview:_viewTable];
    UIImageView *img2=[[UIImageView alloc]initWithFrame:_viewTable.bounds];
    [img2 setImage:imgTable];
    [_viewTable addSubview:img2];
    //table
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-170) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setSeparatorColor:[UIColor grayColor]];
    [_viewTable addSubview:_tableView];
    
}
-(void)initTableCellView:(UITableViewCell *)tableCell{
    tableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *labDay=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    labDay.tag=TAG_CELL_DAY;
    [labDay setBackgroundColor:[UIColor clearColor]];
    [tableCell.contentView addSubview:labDay];
    [labDay release];
    UILabel *labFlow=[[UILabel alloc]initWithFrame:CGRectMake(200, 10, 120, 30)];
    labFlow.tag=TAG_CELL_FLOW;
    [labFlow setBackgroundColor:[UIColor clearColor]];
    [tableCell.contentView addSubview:labFlow];
    [labFlow release];
}
@end
