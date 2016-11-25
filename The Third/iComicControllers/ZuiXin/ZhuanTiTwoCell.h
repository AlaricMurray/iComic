//
//  ZhuanTiTwoCell.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICTuiJian3Cell.h"
#import "ICTuiJianCell.h"


@protocol ICJumptoAuthorDelegate <NSObject>

-(void)jumptoAuthor:(NSString *)url;

@end


@interface ZhuanTiTwoCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *ZTcollect2View;
@property (strong, nonatomic) IBOutlet UILabel *editLabel2;
@property (strong, nonatomic) IBOutlet UIView *icLine2;
@property (nonatomic ,strong)NSMutableArray * dataArray;
- (IBAction)moreButton:(id)sender;

@property (nonatomic ,assign)id<JumptoDetailDelegate>delegate;
@property (nonatomic ,assign)id<ICJumptoMoreDelegate>moreDelegate;
@property (nonatomic ,assign)id<ICJumptoAuthorDelegate>authorDelegate;

@property (nonatomic , assign)int ictag;
@property (nonatomic , strong) NSString * moreUrl;
-(void)sendHttpRequestTwo:(NSInteger)tag;

@end
