//
//  ICFunction.h
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SuccessBlock)(id object);
typedef void (^FailureBlock)(NSError * error);
@interface ICFunction : NSObject

+(void)getHttpURL:(UIViewController *)viewController andWithUrl:(NSString *)url andWithType:(NSString *)type completation:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)FailtoConnection;
+(void)DownloadImage:(NSString *)url andWithImageView:(UIImageView *)bgImageView;
@end
