//
//  DemoViewController.m
//  sadam
//
//  Created by myf on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "ICRootViewController.h"
#import "TuiJianViewController.h"
#import "FenLeiViewController.h"
#import "ZhuanTiViewController.h"
#import "ZiXunViewController.h"
#import "DLFixedTabbarView.h"
#import "Header.h"
#import "ICSettingController.h"
@interface ICRootViewController ()

@end

@implementation ICRootViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createSlideView];
    [self createUI];
    
    
}

-(void)createUI{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2015.jpg"] forBarMetrics:UIBarMetricsDefault];
    UIImageView * BgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, 44)];
    BgImageView.image = [UIImage imageNamed:@"25555552.jpg"];
    
    [self.view insertSubview:BgImageView belowSubview:self.tabedSlideView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-60, 10, 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"rset.png"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


-(void)buttonClick:(UIButton *)button{
    
    ICSettingController * icset = [[ICSettingController alloc]init];
    [self.navigationController pushViewController:icset animated:YES];
    
}

-(void)createSlideView{
    
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor whiteColor];

    self.tabedSlideView.tabItemSelectedColor = [UIColor whiteColor];
    
    self.tabedSlideView.tabbarTrackColor = [UIColor whiteColor];

    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"推荐" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"分类" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"专题" image:nil selectedImage:nil];
    DLTabedbarItem * item4 = [DLTabedbarItem itemWithTitle:@"资讯" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3,item4];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    
    
}
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 4;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            TuiJianViewController *iComic = [[TuiJianViewController alloc] init];
            return iComic;
        }
        case 1:
        {
            FenLeiViewController *iComic = [[FenLeiViewController alloc] init];
            return iComic;
        }
        case 2:
        {
            ZhuanTiViewController *iComic = [[ZhuanTiViewController alloc] init];
            return iComic;
        }
        case 3:
        {
            ZiXunViewController * iComic = [[ZiXunViewController alloc]init];
            return iComic;
        }

        default:
            return nil;
    }
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
