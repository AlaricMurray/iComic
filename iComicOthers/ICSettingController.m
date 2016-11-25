//
//  ICSettingController.m
//  iComic
//
//  Created by myf on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICSettingController.h"
#import "ICCommitController.h"
#import "ICSaveController.h"


@interface ICSettingController ()


@end

@implementation ICSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)createUI{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
}

-(void)buttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)changeButton:(id)sender {
    
    ICSaveController * icSave = [[ICSaveController alloc]init];
    [self.navigationController pushViewController:icSave animated:YES];
   
}

- (IBAction)commitButton:(id)sender {
    
    ICCommitController * icCommit = [[ICCommitController alloc]init];
    [self.navigationController pushViewController:icCommit animated:YES];
    
}


@end
