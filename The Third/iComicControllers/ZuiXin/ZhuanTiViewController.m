//
//  ZhuanTiViewController.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZhuanTiViewController.h"
#import "Header.h"
#import "ZhuanTi1Cell.h"
#import "ZhuanTi2Cell.h"
#import "ZhuanTiTwoCell.h"
#import "ICSYDetailController.h"
#import "ICMoreController.h"
#import "ICAuthorMoreController.h"
@interface ZhuanTiViewController ()<UITableViewDataSource,UITableViewDelegate,JumptoDetailDelegate,ICJumptoMoreDelegate,ICJumptoAuthorDelegate>

@property (nonatomic ,strong)UITableView * tableView;
@end

@implementation ZhuanTiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}



-(void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height-80) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
       
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        return 200;
    }
    else{
        return 150;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString * iden = @"zhuanti1";
        ZhuanTi1Cell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZhuanTi1Cell" owner:nil options:nil] lastObject];
        }
        
        return cell;
    }
    
    if (indexPath.row == 1||indexPath.row == 5) {
        static NSString * iden = @"zhuanti2";
        ZhuanTi2Cell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZhuanTi2Cell" owner:nil options:nil] lastObject];
        }
        if (indexPath.row == 1) {
            cell.editLabel.text =@"这些漫画推荐追哦";
            cell.ictag = 10;
            [cell sendHttpRequest:100];
        }
      
        if (indexPath.row == 5) {
            cell.editLabel.text =@"漫画期刊看这里";
            cell.ictag = 20;
            [cell sendHttpRequest:200];
        }
        cell.delegate = self;
        cell.moreDelegate = self;
        cell.icLine.alpha = 0.35;
        return cell;
      }
    else{
        
        static NSString * iden = @"zt";
        ZhuanTiTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZhuanTiTwoCell" owner:nil options:nil]lastObject];
        }  if (indexPath.row == 2) {
            cell.editLabel2.text =@"最新漫画情报";
            cell.ictag = 30;
            [cell sendHttpRequestTwo:300];

        }
        if (indexPath.row == 3) {
            cell.editLabel2.text =@"女生漫画专区";
            cell.ictag = 40;
            [cell sendHttpRequestTwo:400];
        }
        if (indexPath.row == 4) {
            cell.editLabel2.text =@"男生漫画专区";
            cell.ictag = 50;
            [cell sendHttpRequestTwo:500];
        }
        if (indexPath.row == 6) {
            cell.editLabel2.text =@"你喜欢的漫画家都在这里";
            cell.ictag = 60;
            cell.authorDelegate = self;
            [cell sendHttpRequestTwo:600];
        }
        cell.delegate = self;
        cell.moreDelegate = self;
         cell.icLine2.alpha = 0.35;
        return cell;
    }

}

-(void)jumptodetail:(NSInteger)id Name:(NSString *)name{
    
    ICSYDetailController * detail = [[ICSYDetailController alloc]init];
    detail.urlId = id;
    detail.urlName = name;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
-(void)jumptoMore:(NSString *)url{
    
    ICMoreController * moreVC = [[ICMoreController alloc]init];
    moreVC.strurl = url;
    [self.navigationController pushViewController:moreVC animated:YES];
    
}


-(void)jumptoAuthor:(NSString *)url{
    
    ICAuthorMoreController * authorVC = [[ICAuthorMoreController alloc]init];
    authorVC.moreUrl = url;
    [self.navigationController pushViewController:authorVC animated:YES];
    
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
