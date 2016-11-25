//
//  ZiXunViewController.m
//  iComic
//
//  Created by myf on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZiXunViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "ICFunction.h"
#import "ICZiXunCell.h"
#import "ZiXunModel.h"
#import "UIImageView+WebCache.h"
#import "ZiXunDetailViewController.h"
@interface ZiXunViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView * tableView;
@property (nonatomic , strong)NSMutableArray * dataArray;

@end

@implementation ZiXunViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}


-(void)createUI{
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10,0, ICWIDTH-20, ICHEIGHT-80+2) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self sendHttpRequest];
    
}

-(void)sendHttpRequest{
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];

    [ICFunction getHttpURL:self andWithUrl:ZIXUNURL andWithType:@"text/html" completation:^(id object) {
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSArray * icArray = object[@"data"];
            for (NSDictionary * icDict in icArray) {
                ZiXunModel * model = [[ZiXunModel alloc]init];
                [model setZiXunvaluesByDictionary:icDict];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [ICFunction FailtoConnection];

    }];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * zixun = @"zixun";
    ICZiXunCell * cell = [tableView dequeueReusableCellWithIdentifier:zixun];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ICZiXunCell" owner:nil options:nil] lastObject];
    }
    ZiXunModel * model = _dataArray[indexPath.section];
    if ([model.pic_url isEqualToString:@""]) {
        cell.iconImageView.image = [UIImage imageNamed:@"actbg"];
    }else{
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.pic_url]];
    }
    cell.icDescLabel.text = model.title;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZiXunDetailViewController * detail = [[ZiXunDetailViewController alloc]init];
   
    detail.model = _dataArray[indexPath.section];
    detail.iczixun = detail.model.id;
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
