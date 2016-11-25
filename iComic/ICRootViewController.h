//
//  DemoViewController.h
//  sadam
//
//  Created by myf on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"
@interface ICRootViewController : UIViewController<DLTabedSlideViewDelegate>
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;
-(void)createUI;
@end
