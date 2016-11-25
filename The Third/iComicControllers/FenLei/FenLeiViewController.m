//
//  FenLeiViewController.m
//  iComic
//
//  Created by myf on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FenLeiViewController.h"
#import "ICCollectionViewCell.h"
#import "ICFunction.h"
#import "Header.h"
#import "FenLeiModel.h"
#import "FenLeiDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface FenLeiViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)UICollectionView * collectionView;
@property (nonatomic ,strong)NSMutableArray * dataArray;

@end

@implementation FenLeiViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self createUI];
    [self sendRequestWithURL:FENLEI];
    
    
}



-(void)createUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
 
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, ICWIDTH, ICHEIGHT-80) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ICCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ic"];
    
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = YES;
    [self.view addSubview:_collectionView];
    [_collectionView reloadData];
 
    
}





-(void)sendRequestWithURL:(NSString *)fenleiUrl {
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [ICFunction getHttpURL:self andWithUrl:fenleiUrl andWithType:@"text/plain" completation:^(id object) {
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * icArray = [NSArray arrayWithArray:object];
            for (NSDictionary * dict in icArray) {
                FenLeiModel * model = [[FenLeiModel alloc]init];
                [model setFenLeiValuesByNSDictionary:dict];
                [_dataArray addObject:model];
            }
            [_collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        [ICFunction FailtoConnection];
    }];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 20;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 80);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    ICCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"ic" forIndexPath:indexPath];
    
    FenLeiModel * model = _dataArray[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.CatalogSelfURL]];
    cell.nameLabel.text = model.CatalogName;
    
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FenLeiModel * model = _dataArray[indexPath.item];
  
    FenLeiDetailViewController * detail = [[FenLeiDetailViewController alloc]init];
    detail.icId = model.CatalogID;
    detail.titleName = model.CatalogName;
    [self.navigationController pushViewController:detail animated:YES];
   
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
