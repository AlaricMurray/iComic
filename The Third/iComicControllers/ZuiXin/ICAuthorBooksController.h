//
//  ICAuthorBooksController.h
//  iComic
//
//  Created by myf on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICAuthorBooksController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic ,strong)NSString * icTitle;
@property (nonatomic ,strong)NSString * picUrl;
@property (nonatomic ,strong)NSString * desc;
@end
