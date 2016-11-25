//
//  ICTuiJianCell.m
//  iComic
//
//  Created by myf on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICTuiJianCell.h"
#import "Header.h"
#import "ShouYeModel.h"
#import "ICFunction.h"
#import "ICRootViewController.h"
#import "ICCollectionViewCell3.h"
#import "UIImageView+WebCache.h"

@implementation ICTuiJianCell

- (void)awakeFromNib {
    // Initialization code
    [self createUI];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)createUI{
    
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.icCollectionView1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-120, [[UIScreen mainScreen]bounds].size.width, 120) collectionViewLayout:flow];
    self.icCollectionView1.backgroundColor = [UIColor whiteColor];
    
    self.icCollectionView1.delegate = self;
    self.icCollectionView1.dataSource = self;
    
    
    [self.icCollectionView1 registerNib:[UINib nibWithNibName:@"ICCollectionViewCell3" bundle:nil] forCellWithReuseIdentifier:@"collect1"];
    
    self.icCollectionView1.showsHorizontalScrollIndicator = NO;
    self.icCollectionView1.bounces = YES;
    [self addSubview:self.icCollectionView1];
    [self.icCollectionView1 reloadData];
    
    
}
-(void)sendHttpRequestWithTag:(NSInteger)tag{
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];


    ICRootViewController * ic1 = [[ICRootViewController alloc]init];
    [ICFunction getHttpURL:ic1 andWithUrl:SHOUYE andWithType:@"text/plain"  completation:^(id object) {
        if ([object isKindOfClass:[NSArray class]]) {
            if (tag == 1) {
                _dataArray = [[NSMutableArray alloc]initWithCapacity:0];

                NSArray * _icFirstArray = [NSArray arrayWithArray:object];
                for (int i =5; i<10; i++) {
                    NSDictionary * dict = _icFirstArray[i];
                    ShouYeModel * model = [[ShouYeModel alloc]init];
                    [model setShouYeValuesByDictionary:dict];
                    [_dataArray addObject:model];

                }
                
            }

        }
            if (tag == 2) {
                _dataArray = [[NSMutableArray alloc]initWithCapacity:0];

                NSArray * _icSecondArray = [NSArray arrayWithArray:object];
                for (int i = 10; i<15; i++) {
                    NSDictionary * dict = _icSecondArray[i];
                    ShouYeModel * model = [[ShouYeModel alloc]init];
                    [model setShouYeValuesByDictionary:dict];
                    [_dataArray addObject:model];
                }

            }
            
            if (tag == 3) {
                _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
                NSArray * _icThirdArray = [NSArray arrayWithArray:object];
                for (int i = 15; i<_icThirdArray.count; i++) {
                    
                    NSDictionary * dict = _icThirdArray[i];
                    ShouYeModel * model = [[ShouYeModel alloc]init];
                    [model setShouYeValuesByDictionary:dict];
                    [_dataArray addObject:model];
                    
                  
                }

            }
                       [self.icCollectionView1 reloadData];
        }
        
    failure:^(NSError *error) {
        NSLog(@"%@",error);
        [ICFunction FailtoConnection];

    }];
    
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


- (IBAction)icMoreButton:(id)sender {
    if (_ictag == 10) {
        _moreUrl = NEWURL;
    }
    if (_ictag == 20) {
        _moreUrl = COLLECTURL;
    }
    if (_ictag == 30) {
        _moreUrl = POPULARURL;
    }
    
    [self.moreDelegate jumptoMore:_moreUrl];
    
    
}
@end
