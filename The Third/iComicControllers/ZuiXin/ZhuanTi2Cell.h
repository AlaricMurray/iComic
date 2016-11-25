//
//  ZhuanTi2Cell.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICTuiJian3Cell.h"
#import "ICTuiJianCell.h"

@interface ZhuanTi2Cell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UILabel *editLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *ZTCollection1View;
@property (strong, nonatomic) IBOutlet UIView *icLine;
@property (nonatomic ,strong)NSMutableArray * dataArray;
- (IBAction)MoreButton:(id)sender;

@property (nonatomic ,assign)id<JumptoDetailDelegate>delegate;
@property (nonatomic ,assign)id<ICJumptoMoreDelegate>moreDelegate;
@property (nonatomic , assign)int ictag;
@property (nonatomic , strong) NSString * moreUrl;

-(void)sendHttpRequest:(NSInteger)tag;

@end
