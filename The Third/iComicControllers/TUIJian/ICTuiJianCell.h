//
//  ICTuiJianCell.h
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICTuiJian3Cell.h"

@protocol ICJumptoMoreDelegate <NSObject>

-(void)jumptoMore:(NSString *)url;

@end



@interface ICTuiJianCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *cateLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *icCollectionView1;
- (IBAction)icMoreButton:(id)sender;
@property (nonatomic , assign)id<ICJumptoMoreDelegate>moreDelegate;
@property (nonatomic , strong) NSMutableArray * dataArray;
@property (nonatomic , strong) NSString * moreUrl;
@property (nonatomic , assign)id<JumptoDetailDelegate>delegate;
-(void)sendHttpRequestWithTag:(NSInteger)tag;
@property (nonatomic , assign)int ictag;
@end
