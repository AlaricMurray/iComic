//
//  TuiJianViewController.m
//  iComic
//
//  Created by myf on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TuiJianViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ICFunction.h"
#import "ICTuiJianCell.h"
#import "ICTuiJian2Cell.h"
#import "ICTuiJian3Cell.h"
#import "ICCollectionViewCell3.h"
#import "ZiXunDetailViewController.h"
#import "ICSYDetailController.h"
#import "ICMoreController.h"
@interface TuiJianViewController ()<UITableViewDataSource,UITableViewDelegate,JumptoDetailDelegate,ICJumptoMoreDelegate>


@property (nonatomic , strong)NSMutableArray * icDataArray;
@property (nonatomic , strong)NSMutableArray * icZiXunArray;
@property (nonatomic , strong)UITableView * icTableView;
@property (nonatomic , strong)NSArray * icFirstArray;
@end

@implementation TuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}


-(void)createTableView{
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    _icDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _icZiXunArray = [[NSMutableArray alloc]initWithCapacity:0];
    _icTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ICWIDTH, ICHEIGHT-80+2) style:UITableViewStylePlain];
    _icTableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.1];
    _icTableView.showsVerticalScrollIndicator = NO;
    _icTableView.bounces = NO;
    _icTableView.delegate = self;
    _icTableView.dataSource = self;
    [self.view addSubview:_icTableView];
    [_icTableView registerNib:[UINib nibWithNibName:@"ICTuiJianCell" bundle:nil] forCellReuseIdentifier:@"iden"];
    [_icTableView registerNib:[UINib nibWithNibName:@"ICTuiJian2Cell" bundle:nil] forCellReuseIdentifier:@"two"];
    [_icTableView registerNib:[UINib nibWithNibName:@"ICTuiJian3Cell" bundle:nil] forCellReuseIdentifier:@"three"];
    
   
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 400;
    }else if (indexPath.section == 1)
    {
        return 70;
    }else{
        return 170;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 20;
    }
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * ICBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ICWIDTH, 20)];
    ICBgView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    return ICBgView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        ICTuiJian3Cell * cell3 = [tableView dequeueReusableCellWithIdentifier:@"three" forIndexPath:indexPath];

        cell3.backgroundColor = [UIColor clearColor];
        cell3.delegate = self;

        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
          return cell3;
        
        
    }else if (indexPath.section == 1)
    {
        
        ICTuiJian2Cell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.delegate = self;
        
        return cell2;
    }else{
        ICTuiJianCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"iden" forIndexPath:indexPath];
        if (indexPath.section == 2) {
            UIImage * icImage = [UIImage imageNamed:@"bestnewicon"];
            cell1.iconImageView.image = icImage;
            cell1.cateLabel.text = @"最多评论";
            cell1.ictag = 10;
            [cell1 sendHttpRequestWithTag:1];
            
        }else if (indexPath.section == 3){
            UIImage * icImage = [UIImage imageNamed:@"hotpopicon"];
            cell1.iconImageView.image = icImage;
            cell1.cateLabel.text = @"最多收藏";
            cell1.ictag = 20;

            [cell1 sendHttpRequestWithTag:2];
            
        }else{
           
            UIImage * icImage = [UIImage imageNamed:@"likeicon"];
            cell1.iconImageView.image = icImage;
            cell1.cateLabel.text = @"最多人气";
            cell1.ictag = 30;
            
            [cell1 sendHttpRequestWithTag:3];
        }
        cell1.moreDelegate = self;
        cell1.delegate = self;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell1;
    }
    
}

-(void)jumptoZiXunDetail:(NSString *)Id{
    ZiXunDetailViewController * detail = [[ZiXunDetailViewController alloc]init];
    detail.iczixun = Id;
    
    [self.navigationController pushViewController:detail animated:YES];
    
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
