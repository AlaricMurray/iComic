//
//  ICCommitController.m
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICCommitController.h"

@interface ICCommitController ()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation ICCommitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
    
}

-(void)createUI{
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_infoTextField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_infoTextField resignFirstResponder];
    [_infoTextView resignFirstResponder];
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

- (IBAction)sendButton:(id)sender {
    
    if ([_infoTextField.text isEqualToString:@""]||[_infoTextView.text isEqualToString:@""]) {
        UIAlertView * erAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的联系方式或消息不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [erAlert show];
    }else{
    
    UIAlertView * icAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息已发送，感谢您的支持" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    _infoTextField.text = nil;
    _infoTextView.text = nil;
    [icAlert show];
    }
}
@end
