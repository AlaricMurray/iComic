//
//  ICTuiJian3Cell.h
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JumptoDetailDelegate <NSObject>

-(void)jumptodetail:(NSInteger)id Name:(NSString *)name;

@end

@interface ICTuiJian3Cell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)NSString * strurl;

//@property (strong, nonatomic) IBOutlet UICollectionView *icCollectionView;
@property (nonatomic ,strong)UICollectionView * icCollectionView;
@property (nonatomic , strong)NSMutableArray * array;

@property (nonatomic , assign)id<JumptoDetailDelegate>delegate;

@end
