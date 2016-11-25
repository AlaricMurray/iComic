//
//  DetailModel.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
-(void)setDetailValuesByDictionary:(NSDictionary *)dict{
    
    self.BookID = [dict[@"BookID"] integerValue];
    self.BookName = dict[@"BookName"];
    self.BookDescription = dict[@"BookDescription"];
    self.BookIconOtherURL = dict[@"BookIconOtherURL"];
    self.BookAuthor = dict[@"BookAuthor"];
    self.BookUpdateDate = dict[@"BookUpdateDate"];
    self.BookStateName = dict[@"BookStateName"];
    self.CatalogName = dict[@"CatalogName"];
    self.BookClickCount = [dict[@"BookClickCount"] integerValue];
    
}
@end
