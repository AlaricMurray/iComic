//
//  ZhuanTi2Cell.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZhuanTi2Cell.h"
#import "ICFunction.h"
#import "Header.h"
#import "ICCollectionViewCell3.h"
#import "UIImageView+WebCache.h"
#import "ShouYeModel.h"
#import "SrollModel.h"
@implementation ZhuanTi2Cell

- (void)awakeFromNib {
    // Initialization code

    [self createUI];
    
}

-(void)createUI{
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _ZTCollection1View = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-120, [[UIScreen mainScreen]bounds].size.width, 120) collectionViewLayout:flow];
   _ZTCollection1View.backgroundColor = [UIColor whiteColor];
  _ZTCollection1View.delegate = self;
    _ZTCollection1View.dataSource = self;
     [_ZTCollection1View registerNib:[UINib nibWithNibName:@"ICCollectionViewCell3" bundle:nil] forCellWithReuseIdentifier:@"collect1"];
    
    _ZTCollection1View.showsHorizontalScrollIndicator = NO;
    _ZTCollection1View.bounces = YES;
    [self addSubview:_ZTCollection1View];
    [_ZTCollection1View reloadData];
    
    
}





-(void)sendHttpRequest:(NSInteger)tag{
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];

    [ICFunction getHttpURL:nil andWithUrl:ZHUANTI andWithType:@"text/plain"  completation:^(id object) {
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * array = [NSArray arrayWithArray:object];
            if (tag == 100) {
            for (int i =0; i<5; i++) {
                
                NSDictionary * dict = array[i];
                ShouYeModel * model = [[ShouYeModel alloc]init];
                [model setShouYeValuesByDictionary:dict];
                [_dataArray addObject:model];
            }
        }
            if (tag == 200) {
                for (int i =5; i<11; i++) {
                    NSDictionary * dict = array[i];
                    ShouYeModel * model = [[ShouYeModel alloc]init];
                    [model setShouYeValuesByDictionary:dict];
                    [_dataArray addObject:model];
                }
            }
            
            [self.ZTCollection1View reloadData];
        }
        
    } failure:^(NSError *error) {
        [ICFunction FailtoConnection];
    }];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 40;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 120);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ICCollectionViewCell3 * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect1" forIndexPath:indexPath];
    
    ShouYeModel * model = _dataArray[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.BookIconOtherURL]];
    cell.titleLabel.text = model.BookName;
    cell.timeLabel.text = model.BookUpdateSection;
    cell.icNewIconImageView.hidden = YES;

    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShouYeModel * model = _dataArray[indexPath.item];
    [self.delegate jumptodetail:model.BookID Name:model.BookName];
    
}


- (IBAction)MoreButton:(id)sender {
    
    if (_ictag == 10) {
        _moreUrl = TUIJIANMORE;
    }
    if (_ictag == 20) {
        _moreUrl = MAGZINEMORE;
    }
    
    [self.moreDelegate jumptoMore:_moreUrl];

}
@end
