//
//  FenLeiModel.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FenLeiModel.h"

@implementation FenLeiModel


-(void)setFenLeiValuesByNSDictionary:(NSDictionary *)dict{
    
    
    self.CatalogID = [dict[@"CatalogID"] integerValue];
    self.CatalogName = dict[@"CatalogName"];

    self.CatalogSelfURL = dict[@"CatalogSelfURL"];

    self.CatalogTargetURL1 = dict[@"CatalogTargetURL1"];

    
}

@end
