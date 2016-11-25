//
//  ZhuanTiTwoCell.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZhuanTiTwoCell.h"
#import "ICFunction.h"
#import "Header.h"
#import "icZTCollectCell.h"
#import "UIImageView+WebCache.h"
#import "SrollModel.h"
@implementation ZhuanTiTwoCell

- (void)awakeFromNib {
    // Initialization code
    [self createUI];
}
-(void)createUI{
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _ZTcollect2View = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-120, [[UIScreen mainScreen]bounds].size.width, 120) collectionViewLayout:flow];
    _ZTcollect2View.backgroundColor = [UIColor whiteColor];
    
    _ZTcollect2View.delegate = self;
    _ZTcollect2View.dataSource = self;
    [_ZTcollect2View registerNib:[UINib nibWithNibName:@"icZTCollectCell" bundle:nil] forCellWithReuseIdentifier:@"ztcollect"];
    
    _ZTcollect2View.showsHorizontalScrollIndicator = NO;
    _ZTcollect2View.bounces = YES;
    [self addSubview:_ZTcollect2View];
    [_ZTcollect2View reloadData];
    
}






-(void)sendHttpRequestTwo:(NSInteger)tag{
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [ICFunction getHttpURL:nil andWithUrl:ZHUANTITWO andWithType:@"text/plain"  completation:^(id object) {
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * array = [NSArray arrayWithArray:object];
            if (tag == 300) {
                
                for (int i =0; i<3; i++) {
                    
                    NSDictionary * dict = array[i];
                    SrollModel * model = [[SrollModel alloc]init];
                    [model setSrollValuesByDictionary:dict];
                    [_dataArray addObject:model];
                }
            }
            if (tag == 400) {
                for (int i =3; i<5; i++) {
                    
                    NSDictionary * dict = array[i];
                    SrollModel * model = [[SrollModel alloc]init];
                    [model setSrollValuesByDictionary:dict];
                    [_dataArray addObject:model];
                }
            }
            if (tag == 500) {
                for (int i =5; i<7; i++) {
                    
                    NSDictionary * dict = array[i];
                    SrollModel * model = [[SrollModel alloc]init];
                    [model setSrollValuesByDictionary:dict];
                    [_dataArray addObject:model];
                }
            }
            if (tag == 600) {
                for (int i =7; i<9; i++) {
                    
                    NSDictionary * dict = array[i];
                    SrollModel * model = [[SrollModel alloc]init];
                    [model setSrollValuesByDictionary:dict];
                    [_dataArray addObject:model];
                }
            }
            [_ZTcollect2View reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 50;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 15, 0, 10);
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2-16.5, CGRectGetHeight(collectionView.frame));

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    icZTCollectCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"ztcollect" forIndexPath:indexPath];
    
    SrollModel * model = _dataArray[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.TopicIconUrl]];
    cell.descLabel.text = model.TopicName;

    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        _moreUrl = COLLECTURL;
        [self.moreDelegate jumptoMore:_moreUrl];

    }
    if (indexPath.row == 1) {
        _moreUrl = POPULARURL;
        [self.moreDelegate jumptoMore:_moreUrl];

    }

}
- (IBAction)moreButton:(id)sender {

    if (_ictag == 30) {
        _moreUrl = NEWURL;
        [self.moreDelegate jumptoMore:_moreUrl];
    }
    if (_ictag == 40) {
        _moreUrl = COLLECTURL;
        [self.moreDelegate jumptoMore:_moreUrl];

    }
    if (_ictag == 50) {
        _moreUrl = POPULARURL;
        [self.moreDelegate jumptoMore:_moreUrl];

    }
    if (_ictag == 60) {
        _moreUrl = AUTHORMORE;
        [self.authorDelegate jumptoAuthor:_moreUrl];
    }
 

}
@end
