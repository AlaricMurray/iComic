//
//  SrollModel.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SrollModel.h"

@implementation SrollModel



-(void)setSrollValuesByDictionary:(NSDictionary *)dict{
    
    self.TopicName = dict[@"TopicName"];
    self.TopicIconUrl = dict[@"TopicIconUrl"];
    self.TopicID = [dict[@"TopicID"] integerValue];
    self.TopicDescription = dict[@"TopicDescription"];
    self.BookIDs = dict[@"BookIDs"];
    
}

@end
