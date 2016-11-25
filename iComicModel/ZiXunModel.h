//
//  ZiXunModel.h
//  iComic
//
//  Created by myf on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZiXunModel : NSObject


@property (nonatomic , strong) NSString * title;
@property (nonatomic , strong) NSString * html_url;
@property (nonatomic , strong) NSString * pic_url;
@property (nonatomic , strong) NSString * id;
-(void)setZiXunvaluesByDictionary:(NSDictionary *)iCDict;
@end
