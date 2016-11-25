//
//  ShouYeModel.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouYeModel : NSObject


@property (nonatomic ,assign)NSInteger BookID;
@property (nonatomic ,strong)NSString * BookName;
@property (nonatomic ,strong)NSString * BookDescription;
@property (nonatomic ,strong)NSString * BookIconOtherURL;
@property (nonatomic ,strong)NSString * BookAuthor;
@property (nonatomic ,strong)NSString * BookUpdateSection;
@property (nonatomic ,strong)NSString * BookLinkURL;



-(void)setShouYeValuesByDictionary:(NSDictionary *)dict;

@end
