//
//  MessageSend.h
//  MyFlow
//
//  Created by CL7RNEC on 13-2-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MessageSend : UIViewController<MFMessageComposeViewControllerDelegate>

@property (strong,nonatomic) NSString *message;
@property (strong,nonatomic) NSString *phoneNum;

@end
