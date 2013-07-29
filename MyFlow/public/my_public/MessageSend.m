//
//  MessageSend.m
//  MyFlow
//
//  Created by CL7RNEC on 13-2-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "MessageSend.h"
#import "TKAlertCenter.h"
#import "PublicCheck.h"
#import "PublicDevice.h"
@interface MessageSend ()

@end

@implementation MessageSend

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([PublicDevice isIPod]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"您的设备不支持短信", nil)];
        return;
    }
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    controller.body = _message;
    controller.messageComposeDelegate = self;
    //添加联系人
    if (![PublicCheck validateEmpty:_phoneNum]) {
        controller.recipients = [NSArray arrayWithObjects:_phoneNum, nil];
    }
    [self presentModalViewController:controller animated:YES];
}

- (void)viewDidUnload
{
    _message=nil;
    _phoneNum=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            CLog(@"[sms]Cancelled");
            break;
        case MessageComposeResultFailed:
            CLog(@"[sms]fail");
            break;
        case MessageComposeResultSent:
            
            CLog(@"[sms]ok");
            break;
            
        default:
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
