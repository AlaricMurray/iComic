//
//  ListModel.m
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel
-(void)setListValuesByDictionary:(NSDictionary *)dict{
    
    self.sectionID = [dict[@"SectionID"] integerValue];
    self.sectionName = dict[@"SectionName"];
    self.picCount = [dict[@"PicCount"] integerValue];
    self.sectionLinkURL = dict[@"SectionLinkURL"];
}

@end
