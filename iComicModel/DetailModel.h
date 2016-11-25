//
//  DetailModel.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic ,assign)NSInteger BookID;
@property (nonatomic ,strong)NSString * BookName;
@property (nonatomic ,strong)NSString * BookDescription;
@property (nonatomic ,strong)NSString * BookIconOtherURL;
@property (nonatomic ,strong)NSString * BookAuthor;
@property (nonatomic ,strong)NSString * BookUpdateDate;
@property (nonatomic ,strong)NSString * BookStateName;
@property (nonatomic ,strong)NSString * CatalogName;
@property (nonatomic ,assign)NSInteger BookClickCount;



-(void)setDetailValuesByDictionary:(NSDictionary *)dict;

@end
