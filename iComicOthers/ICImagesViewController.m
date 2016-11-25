//
//  ICImagesViewController.m
//  iComic
//
//  Created by myf on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICImagesViewController.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "ICFunction.h"
@interface ICImagesViewController ()

@end

@implementation ICImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}



-(void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    
    _icImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ICWIDTH, ICHEIGHT-44)];
    [ICFunction DownloadImage:self.picstr andWithImageView:_icImageView];
    
    [self.view addSubview:_icImageView];
    
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
