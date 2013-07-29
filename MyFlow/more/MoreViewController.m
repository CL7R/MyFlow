//
//  MoreController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "MoreViewController.h"
#import "DefaultFileDataManager.h"
#import "AboutViewController.h"
#import "PublicPicture.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

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
    self.navigationItem.title=NSLocalizedString(@"更多", nil);
    NSString *path=[[NSBundle mainBundle]pathForResource:@"more" ofType:@"plist"];
    _dicMore=[[NSDictionary alloc]initWithContentsOfFile:path];
    CLog(@"\n[numberOfSectionsInTableView]%@",path);
    _arrMore=[[_dicMore allKeys]sortedArrayUsingSelector:@selector(compare:)];
    [_arrMore retain];
}
#pragma mark - action
-(void)actionOpenKeyboard:(id)sender{
    
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
    if([[arr objectAtIndex:row] isEqualToString:@"更换背景"]){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"拍照", nil) otherButtonTitles:NSLocalizedString(@"从相册选择", nil), nil];
        [actionSheet addButtonWithTitle:@"默认背景"];
        [actionSheet addButtonWithTitle:@"取消"];
        [actionSheet showInView:[self.view superview]] ;
        [actionSheet release];
    }
    else{
        AboutViewController *about=[[[AboutViewController alloc]init]autorelease];
        [self.navigationController pushViewController:about animated:YES];
    }
}
#pragma mark - Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    CLog(@"\n[imagePickerController--User]%@", image);
    [PublicPicture saveImageToLocal:image Keys:IMAGE_BACKGROUND];
    [DefaultFileDataManager getFileData:DATA_FILE];
    [dicFileData setObject:@"1" forKey:IMAGE];
    [DefaultFileDataManager saveFile];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
}
#pragma mark - actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    CLog(@"\n[actionSheet]%d",buttonIndex);
    if (buttonIndex ==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = (id)self;
        [self presentModalViewController:picker animated:YES];
    }
    else if(buttonIndex ==1){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate = (id)self;
        [self presentModalViewController:picker animated:YES];
    }
    else if(buttonIndex==2){
        [DefaultFileDataManager getFileData:DATA_FILE];
        [dicFileData setObject:@"0" forKey:IMAGE];
        [DefaultFileDataManager saveFile];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_MONTH object:nil];
    }
}
@end
