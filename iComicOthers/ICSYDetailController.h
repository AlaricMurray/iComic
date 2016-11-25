//
//  ICSYDetailController.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail1Cell.h"
@interface ICSYDetailController : UIViewController
@property (nonatomic ,assign)NSInteger urlId;
@property (nonatomic ,strong)NSString * urlName;
@property (nonatomic ,strong)NSString * bookName;
@property (nonatomic ,strong)UIButton * icButton;
@property (nonatomic ,assign)NSInteger ictag;
@end
