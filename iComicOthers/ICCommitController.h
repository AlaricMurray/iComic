//
//  ICCommitController.h
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICCommitController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *infoTextField;
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
- (IBAction)sendButton:(id)sender;

@end
