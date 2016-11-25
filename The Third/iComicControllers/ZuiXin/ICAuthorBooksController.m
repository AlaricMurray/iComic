//
//  ICAuthorBooksController.m
//  iComic
//
//  Created by myf on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICAuthorBooksController.h"
#import "ICFunction.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@interface ICAuthorBooksController ()
@end

@implementation ICAuthorBooksController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}


-(void)createUI{
    
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.icTitle;
    self.descTextView.text= self.desc;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:self.picUrl]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
