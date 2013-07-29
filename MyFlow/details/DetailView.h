//
//  DetailView.h
//  MyFlow
//
//  Created by CL7RNEC on 13-1-26.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

#define TABLE_CELL_HEIGH    50
#define TAG_CELL_DAY        10
#define TAG_CELL_FLOW       11

@interface DetailView : UIView

@property (strong,nonatomic) UIView *viewLine;
@property (strong,nonatomic) CPTXYGraph *graph;
@property (strong,nonatomic) CPTScatterPlot *dataSourceLinePlot;
@property (strong,nonatomic) UIView *viewTable;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UILabel *labTitleDay;
@property (strong,nonatomic) UILabel *labTitleFlow;
@property (strong,nonatomic) UIImageView *imgvTitle;
-(void)initView;
-(void)initTableCellView:(UITableViewCell *)tableCell;
@end
