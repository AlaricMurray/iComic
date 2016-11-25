//
//  ICTuiJian2Cell.h
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ICJumptoZiXunDetailDelegate <NSObject>

-(void)jumptoZiXunDetail:(NSString *)Id;

@end

@interface ICTuiJian2Cell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *icCollectionView2;
@property (nonatomic , strong)NSMutableArray * array;
@property (nonatomic , assign)id<ICJumptoZiXunDetailDelegate>delegate;
@end
