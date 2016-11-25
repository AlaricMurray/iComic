//
//  SrollModel.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SrollModel : NSObject

@property (nonatomic ,strong)NSString * TopicName;
@property (nonatomic ,strong)NSString * TopicIconUrl;
@property (nonatomic ,assign)NSInteger TopicID;
@property (nonatomic ,strong)NSString * TopicDescription;
@property (nonatomic ,strong)NSString * BookIDs;

-(void)setSrollValuesByDictionary:(NSDictionary *)dict;
@end
