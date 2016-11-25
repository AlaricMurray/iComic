//
//  FenLeiModel.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FenLeiModel : NSObject

@property (nonatomic ,assign)NSInteger CatalogID;
@property (nonatomic ,strong)NSString * CatalogName;
@property (nonatomic ,strong)NSString * CatalogSelfURL;
@property (nonatomic ,strong)NSString * CatalogTargetURL1;


-(void)setFenLeiValuesByNSDictionary:(NSDictionary *)dict;

@end
