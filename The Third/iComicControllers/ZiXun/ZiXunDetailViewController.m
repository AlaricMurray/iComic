//
//  ZiXunDetailViewController.m
//  iComic
//
//  Created by myf on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZiXunDetailViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "ZiXunViewController.h"
#import "ICFunction.h"
@interface ZiXunDetailViewController ()<UIWebViewDelegate>

@end

@implementation ZiXunDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}



-(void)createUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"资讯";
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIWebView * icWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ICWIDTH, ICHEIGHT)];
    
    NSString * strurl = [NSString stringWithFormat:@"http://www.mkzhan.com/news/web/%@.html",self.iczixun];
   
    NSURL * icUrl = [NSURL URLWithString:strurl];
    NSURLRequest * request = [NSURLRequest requestWithURL:icUrl];
    [icWebView loadRequest:request];
    icWebView.delegate = self;
    [self.view addSubview:icWebView];
    
    
}
-(void)backButtonClick:(UIBarButtonItem *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  
    [ICFunction FailtoConnection];

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
