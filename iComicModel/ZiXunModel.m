//
//  ZiXunModel.m
//  iComic
//
//  Created by myf on 15/10/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZiXunModel.h"

@implementation ZiXunModel
-(void)setZiXunvaluesByDictionary:(NSDictionary *)iCDict{
    
    
    self.title = iCDict[@"title"];
    self.html_url = iCDict[@"html_url"];
    self.pic_url = iCDict[@"pic_url"];
    self.id = iCDict[@"id"];
    
    
}
@end
