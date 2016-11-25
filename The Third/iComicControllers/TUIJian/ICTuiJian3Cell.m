//
//  ICTuiJian3Cell.m
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICTuiJian3Cell.h"
#import "ICRootViewController.h"
#import "ICCollectionViewCell3.h"
#import "ShouYeModel.h"
#import "RecommandModel.h"
#import "ICFunction.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@implementation ICTuiJian3Cell

- (void)awakeFromNib {
    // Initialization code
    
   
    
    [self createUI];
    [self sendHttpRequest];
}


-(void)createUI{
    
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
   
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.icCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-120, [[UIScreen mainScreen]bounds].size.width, 120) collectionViewLayout:flow];
    self.icCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.icCollectionView.delegate = self;
    self.icCollectionView.dataSource = self;
    
    [self.icCollectionView registerNib:[UINib nibWithNibName:@"ICCollectionViewCell3" bundle:nil] forCellWithReuseIdentifier:@"collect1"];
    
    self.icCollectionView.showsHorizontalScrollIndicator = NO;
    self.icCollectionView.bounces = YES;
    [self addSubview:self.icCollectionView];
    [self.icCollectionView reloadData];
    
    
}



-(void)sendHttpRequest{
    
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    
     ICRootViewController * ic1 = [[ICRootViewController alloc]init];
    
    [ICFunction getHttpURL:ic1 andWithUrl:SHOUYE andWithType:@"text/plain"  completation:^(id object) {
       
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * array = [NSArray arrayWithArray:object];
          
            for (int i =0; i<5; i++) {
                
                NSDictionary * dict = array[i];
                ShouYeModel * model = [[ShouYeModel alloc]init];
                [model setShouYeValuesByDictionary:dict];
                [_array addObject:model];
            }
       
            [self.icCollectionView reloadData];
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
   
    return _array.count;
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
   
   ShouYeModel * model = _array[indexPath.row];
   
   
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.BookIconOtherURL]];
    cell.titleLabel.text = model.BookName;
   
    cell.timeLabel.text = model.BookUpdateSection;

    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    ShouYeModel * model = _array[indexPath.item];
   
    [self.delegate jumptodetail:model.BookID Name:model.BookName];
}


@end
