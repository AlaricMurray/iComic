//
//  ShouYeModel.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShouYeModel.h"

@implementation ShouYeModel


-(void)setShouYeValuesByDictionary:(NSDictionary *)dict{
    
    self.BookID = [dict[@"BookID"] integerValue];
    self.BookName = dict[@"BookName"];
    self.BookDescription = dict[@"BookDescription"];
    self.BookAuthor = dict[@"BookAuthor"];
    self.BookIconOtherURL = dict[@"BookIconOtherURL"];
    self.BookLinkURL = dict[@"BookLinkURL"];
    self.BookUpdateSection = dict[@"BookUpdateSection"];

    
}

@end
