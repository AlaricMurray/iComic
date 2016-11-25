//
//  ICFunction.m
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICFunction.h"
#import "AFNetworking.h"
#import "Header.h"
@implementation ICFunction

+(void)getHttpURL:(UIViewController *)viewController andWithUrl:(NSString *)url andWithType:(NSString *)type completation:(SuccessBlock)success failure:(FailureBlock)failure{
    float icWidth = [[UIScreen mainScreen] bounds].size.width;
    float icHeight = [[UIScreen mainScreen] bounds].size.height;
    
    UIImageView * iCImageView = [[UIImageView alloc]initWithFrame:CGRectMake(icWidth/2-60.5, icHeight/2-100, 121, 121)];
    NSMutableArray * icNetArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 1; i<9; i++) {
        [icNetArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"0%d.png",i]]];
    }
    
    iCImageView.animationImages = icNetArray;
    iCImageView.animationDuration = 1;
    iCImageView.animationRepeatCount = 0;
    [viewController.view addSubview:iCImageView];
    [iCImageView startAnimating];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
   
   
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [iCImageView stopAnimating];
        success(responseObject);
       


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        [iCImageView stopAnimating];

    }];
    
    
    
}



+(void)FailtoConnection{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败，请稍后尝试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

+(void)DownloadImage:(NSString *)url andWithImageView:(UIImageView *)bgImageView{

    dispatch_queue_t global_queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    
    dispatch_async(global_queue, ^{
  
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage * image = [UIImage imageWithData:data];
        dispatch_async(main_queue, ^{

            bgImageView.image = image;
            
            
        });
        
    });
}

@end
