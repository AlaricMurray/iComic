//
//  ICAuthorMoreController.m
//  iComic
//
//  Created by myf on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICAuthorMoreController.h"
#import "ICFunction.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "SrollModel.h"
#import "ICAuthorCell.h"
#import "ICAuthorBooksController.h"
@interface ICAuthorMoreController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UICollectionView * collectionView;
@property (nonatomic ,strong)NSMutableArray * dataArray;
@end

@implementation ICAuthorMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}
-(void)createUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"漫画家";
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, ICHEIGHT-44) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ICAuthorCell" bundle:nil] forCellWithReuseIdentifier:@"author"];
    
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = YES;
    [self.view addSubview:_collectionView];
    [_collectionView reloadData];
    
    [self sendRequest:self.moreUrl];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
}


-(void)sendRequest:(NSString * )url{
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [ICFunction getHttpURL:self andWithUrl:url andWithType:@"text/plain" completation:^(id object) {
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * icArray = [NSArray arrayWithArray:object];
            for (NSDictionary * dict in icArray) {
                SrollModel * model = [[SrollModel alloc]init];
                [model setSrollValuesByDictionary:dict];
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
    
    
    return 40;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(120, 80);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ICAuthorCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"author" forIndexPath:indexPath];
    
    SrollModel * model = _dataArray[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.TopicIconUrl]];
    cell.nameLabel.text = model.TopicName;

    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SrollModel * model = _dataArray[indexPath.item];
    
    ICAuthorBooksController * icBook = [[ICAuthorBooksController alloc]init];
    icBook.picUrl = model.TopicIconUrl;
    icBook.desc = model.TopicDescription;
    icBook.icTitle = model.TopicName;
    [self.navigationController pushViewController:icBook animated:YES];
    
    
}
-(void)buttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
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
