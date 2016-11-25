//
//  RecommandModel.h
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommandModel : NSObject

@property (nonatomic , assign)NSInteger recommandID;
@property (nonatomic ,strong)NSString * visibleIDs;
@property (nonatomic ,strong)NSString * moreIDs;



-(void)setRecommandValuesByDiction:(NSDictionary *)dict;
@end
