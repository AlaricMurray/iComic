//
//  RecommandModel.m
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommandModel.h"

@implementation RecommandModel
-(void)setRecommandValuesByDiction:(NSDictionary *)dict{
    
    self.recommandID = [dict[@"RecommandID"] integerValue];
    self.visibleIDs = dict[@"VisibleIDs"];
    self.moreIDs = dict[@"MoreIDs"];
}
@end
