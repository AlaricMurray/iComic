//
//  ICTuiJian2Cell.m
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICTuiJian2Cell.h"
#import "Header.h"
#import "ICFunction.h"
#import "ICCollectionViewCell2.h"
#import "ICRootViewController.h"
#import "UIImageView+WebCache.h"
#import "ZiXunModel.h"
#import "TuiJianViewController.h"
#import "ZiXunDetailViewController.h"
@implementation ICTuiJian2Cell

- (void)awakeFromNib {
    // Initialization code
    
    
    
    [self createUI];
    [self sendHttpRequest];
}



-(void)createUI{
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.icCollectionView2 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, self.frame.size.height) collectionViewLayout:flow];
    self.icCollectionView2.backgroundColor = [UIColor whiteColor];
    
    self.icCollectionView2.delegate = self;
    self.icCollectionView2.dataSource = self;
    
    
    [self.icCollectionView2 registerNib:[UINib nibWithNibName:@"ICCollectionViewCell2" bundle:nil] forCellWithReuseIdentifier:@"collect2"];
    
    self.icCollectionView2.showsHorizontalScrollIndicator = NO;
    self.icCollectionView2.bounces = YES;
    [self addSubview:self.icCollectionView2];
    [self.icCollectionView2 reloadData];
    
    
}


-(void)sendHttpRequest{
    
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    
    ICRootViewController * ic1 = [[ICRootViewController alloc]init];
    [ICFunction getHttpURL:ic1 andWithUrl:ZIXUNURL andWithType:@"text/html"  completation:^(id object) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSArray * _icFirstArray = object[@"data"];
            for (NSDictionary * iCDict in _icFirstArray) {
                ZiXunModel * iCModel = [[ZiXunModel alloc]init];
                
                [iCModel setZiXunvaluesByDictionary:iCDict];
                [_array addObject:iCModel];
            }
            
            
            [self.icCollectionView2 reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [ICFunction FailtoConnection];

    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _array.count;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 40;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(170, 70);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    ICCollectionViewCell2 * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect2" forIndexPath:indexPath];
    
    ZiXunModel * icSecindModel = _array[indexPath.row];
  
    if ([icSecindModel.pic_url isEqualToString:@""]) {
        cell.iconImageView.image = [UIImage imageNamed:@"actbg"];
    }else{
        
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:icSecindModel.pic_url]];
    }
    return cell;

    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ZiXunModel * model = _array[indexPath.row];
    
    [self.delegate jumptoZiXunDetail:model.id];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
