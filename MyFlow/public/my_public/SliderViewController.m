//
//  SliderViewController.m
//  MyFlow
//
//  Created by CL7RNEC on 13-1-27.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "SliderViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SliderViewController ()

@end

@implementation SliderViewController

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
#pragma mark - init
-(void)initView{
    _selectedIndex=0;
    _scaleFactor=0.8;
    //_arrViewController=[[NSMutableArray alloc]init];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];    
    //滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = (id)self;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _scrollView.pagingEnabled = TRUE;
    [_scrollView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:_scrollView];
    //添加视图
    int index=0;
    for (UIViewController *viewCon in _arrViewController){
        [self addViewController:viewCon index:index++];
    }
}
#pragma mark - other
-(void)addViewController:(UIViewController *)viewController
                   index:(int)index{
    
    viewController.view.frame = CGRectMake(self.view.bounds.size.width * index, 0, self.view.frame.size.width, self.view.frame.size.height);
	//viewController.view.backgroundColor = [UIColor colorWithWhite:(index + 1) * 0.2 alpha:1.0];
    [_scrollView addSubview:viewController.view];
    //向左滑动
	UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipView:)];
	[swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[viewController.view addGestureRecognizer:swipeLeft];
	[swipeLeft release];
	//向右滑动
	UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipView:)];
	[swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[viewController.view addGestureRecognizer:swipeRight];
	[swipeRight release];
}
-(void)actionSwipView:(UISwipeGestureRecognizer *)gesture{
    
    int nextIndex=_selectedIndex;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        ++nextIndex;
    }
	else if(gesture.direction ==  UISwipeGestureRecognizerDirectionRight){
        --nextIndex;
    }
    if (nextIndex >= _arrViewController.count || nextIndex == -1) {
        return;
    }
    UIViewController *currentViewController = [_arrViewController objectAtIndex:_selectedIndex];
	UIViewController *nextViewController = [_arrViewController objectAtIndex:nextIndex];
	NSLog(@"\n[actionSwipView]%@\n%@",currentViewController,nextViewController);
	if (nextViewController == nil)
		return;
	
	CGPoint toPoint = _scrollView.contentOffset;
	toPoint.x = nextIndex * _scrollView.bounds.size.width;
	
	//Start positions
	nextViewController.view.transform = CGAffineTransformMakeScale(_scaleFactor, _scaleFactor);
	
	currentViewController.view.layer.masksToBounds = NO;
	currentViewController.view.layer.shadowRadius = 10;
	currentViewController.view.layer.shadowOpacity = 0.5;
	currentViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:currentViewController.view.bounds].CGPath;
	currentViewController.view.layer.shadowOffset = CGSizeMake(5.0, 5.0);
	
	[currentViewController viewWillDisappear:YES];
	
	//Zoom out animation
	[UIView animateWithDuration:0.25
						  delay:0.0
						options:UIViewAnimationCurveEaseInOut
					 animations:^{
						 currentViewController.view.transform = CGAffineTransformMakeScale(_scaleFactor, _scaleFactor);
					 }
					 completion:^(BOOL completed){
						 NSLog(@"\n[Zoom out animation]");
						 //Add shadow to next view controller
						 nextViewController.view.layer.masksToBounds = NO;
						 nextViewController.view.layer.shadowRadius = 10;
						 nextViewController.view.layer.shadowOpacity = 0.5;
						 nextViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:nextViewController.view.bounds].CGPath;
						 nextViewController.view.layer.shadowOffset = CGSizeMake(5.0, 5.0);
						 
						 [nextViewController viewWillAppear:YES];
					 }];
	
	
	//Slide animation
	[UIView animateWithDuration:0.5
						  delay:0.25
						options:UIViewAnimationCurveEaseInOut
					 animations:^{
						 [_scrollView setContentOffset:toPoint];
					 }
					 completion:^(BOOL completed){
						 NSLog(@"\n[Slide animation]");
						 //remove current view controller
						 currentViewController.view.layer.masksToBounds = YES;
						 currentViewController.view.layer.shadowRadius = 10;
						 currentViewController.view.layer.shadowOpacity = 0.0;
						 currentViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:currentViewController.view.bounds].CGPath;
						 currentViewController.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
						 
						 [self calculateSelectedIndex];
						 
						 [currentViewController viewDidDisappear:YES];
					 }];
	
	//Zoom in animation
	[UIView animateWithDuration:0.25
						  delay:0.75
						options:UIViewAnimationCurveEaseInOut
					 animations:^{
						 nextViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
					 }
					 completion:^(BOOL completed){
						 currentViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
						 NSLog(@"\n[Zoom in animation]");
						 //remove shadow next view controller
						 nextViewController.view.layer.masksToBounds = YES;
						 nextViewController.view.layer.shadowRadius = 0.0;
						 nextViewController.view.layer.shadowOpacity = 0.0;
						 nextViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:nextViewController.view.bounds].CGPath;
						 nextViewController.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
						 
						 [nextViewController viewDidAppear:YES];
					 }];
}
- (void)calculateSelectedIndex
{
	_selectedIndex = floor((_scrollView.contentOffset.x - self.view.bounds.size.width / 2) / self.view.bounds.size.width) + 1;
    NSLog(@"\n[calculateSelectedIndex]%d",_selectedIndex);
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self calculateSelectedIndex];
}
@end
