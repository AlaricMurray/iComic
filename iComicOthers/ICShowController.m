//
//  ICShowController.m
//  iComic
//
//  Created by myf on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICShowController.h"
#import "ICFunction.h"
#import "Header.h"
#import "ICImagesViewController.h"
@interface ICShowController ()<UIPageViewControllerDataSource>
@property (nonatomic ,strong)NSMutableArray * dataArray;
@property (nonatomic ,strong)UIPageViewController * pageVC;
@property (nonatomic ,assign)NSInteger index;
@end

@implementation ICShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
  

   
}

-(void)createUI{
    self.navigationItem.title = @"请耐心等待图片加载（^_^）";
    NSString * urlstr = [NSString stringWithFormat:@"http://222.231.4.196:9090/manhuakong/ComicHandle.ashx?cid=20160320&ckey=6710dbw5d09ab935ae9037cd89c4bb1a&method=picturelist&sectionid=%u",self.icId];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
      [self sendRequest:urlstr];
}

-(void)buttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendRequest:(NSString *)strurl{
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [ICFunction getHttpURL:self andWithUrl:strurl andWithType:@"text/plain" completation:^(id object) {
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * icArray = [NSArray arrayWithArray:object];
            for (NSDictionary * dict in icArray) {
                NSString * picUrl = dict[@"PictureURL"];
                [_dataArray addObject:picUrl];
            }
            [self createImages];

        }
        
    } failure:^(NSError *error) {
        [ICFunction FailtoConnection];
    }];
    
}

-(void)createImages{
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:dict];
    _pageVC.dataSource = self;
    [_pageVC.view setFrame:self.view.bounds];
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    
    ICImagesViewController * icImagesVC = [[ICImagesViewController alloc]init];
    icImagesVC.picstr = _dataArray[0];
    icImagesVC.str = @"1";
    NSArray * array = @[icImagesVC];
    [_pageVC setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    ICImagesViewController * firstVC = (ICImagesViewController *)viewController;
    _index = [firstVC.str integerValue];
    if (_index == 1) {
        
        return nil;
    }
    _index--;
    ICImagesViewController * fvc = [[ICImagesViewController alloc]init];
    fvc.str = [NSString stringWithFormat:@"%lu",(long)_index];
    fvc.picstr = _dataArray[_index];
    return fvc;
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    ICImagesViewController * firstVC = (ICImagesViewController *)viewController;
    _index = [firstVC.str integerValue];
    if (_index == _dataArray.count-1) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是最后一页了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return nil;
    }
    _index++;
    ICImagesViewController * fvc = [[ICImagesViewController alloc]init];
    fvc.str = [NSString stringWithFormat:@"%lu",(long)_index];
    fvc.picstr = _dataArray[_index];
    
    

    return fvc;
    
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
