//
//  ListModel.h
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject


@property (nonatomic ,assign)NSInteger sectionID;
@property (nonatomic ,strong)NSString * sectionName;
@property (nonatomic ,assign)NSInteger picCount;
@property (nonatomic ,strong)NSString * sectionLinkURL;
-(void)setListValuesByDictionary:(NSDictionary *)dict;

@end
