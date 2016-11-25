//
//  ICSYDetailController.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICSYDetailController.h"
#import "Header.h"
#import "ICFunction.h"
#import "UIImageView+WebCache.h"
#import "Detail1Cell.h"
#import "DetailModel.h"
#import "ListModel.h"
#import "ICShowController.h"
#import "CoreData+MagicalRecord.h"
#import "Book.h"
@interface ICSYDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)NSMutableArray * listArray;
@property (nonatomic ,strong)DetailModel * detailModel;
@property (nonatomic ,strong)UITableView * tableView;
@end

@implementation ICSYDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.ictag == 100) {
         [_icButton setTitle:@"已收藏" forState:UIControlStateNormal];
    }
    
    NSArray * resultArray = [Book MR_findAll];
    for (Book * icBook in resultArray) {
        if ([icBook.name isEqualToString:_urlName]) {
           
           [_icButton setTitle:@"已收藏" forState:UIControlStateNormal];
        }
    }
}



-(void)createUI{
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"漫画详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ICWIDTH, ICHEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_tableView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
    
   _icButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _icButton.frame = CGRectMake(ICWIDTH-60, 48, 55, 30);
    [_icButton setTitle:@"收藏" forState:UIControlStateNormal];
    _icButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_icButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_icButton setBackgroundImage:[UIImage imageNamed:@"button_back.png"] forState:UIControlStateNormal];
    [_icButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_icButton];
    
    [self sendRequest];
    [self startRequest];
   
  
}


-(void)sendRequest{
 
    NSString * strurl = [NSString stringWithFormat:@"http://222.231.4.196:9090/manhuakong/ComicHandle.ashx?cid=20160320&ckey=6710dbw5d09ab935ae9037cd89c4bb1a&method=booksite&bookname=%@&bookid=%d",self.urlName,self.urlId];
    NSString * realUrl =[strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [ICFunction getHttpURL:self andWithUrl:realUrl andWithType:@"text/plain" completation:^(id object) {
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * icArray = [NSArray arrayWithArray:object];
           
                _detailModel = [[DetailModel alloc]init];
            NSDictionary * dict = [icArray firstObject];
                [_detailModel setDetailValuesByDictionary:dict];

            [_tableView reloadData];
            
        }
        
    } failure:^(NSError *error) {
        [ICFunction FailtoConnection];
    }];
    
}

-(void)buttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)startRequest{
    
    
    _listArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSString * listUrl = [NSString stringWithFormat:@"http://222.231.4.196:9090/manhuakong/ComicHandle.ashx?cid=20160320&ckey=6710dbw5d09ab935ae9037cd89c4bb1a&method=sectionlist&bookid=%u",self.urlId];
    [ICFunction getHttpURL:self andWithUrl:listUrl andWithType:@"text/plain" completation:^(id object) {
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * listArray = [NSArray arrayWithArray:object];
            for (NSDictionary * dict in listArray) {
                ListModel * model = [[ListModel alloc]init];
                [model setListValuesByDictionary:dict];
                [_listArray addObject:model];
            }
           

            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        [ICFunction FailtoConnection];
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count+1;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }
    else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * iden = @"detail1";
    if (indexPath.row == 0) {
        Detail1Cell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"Detail1Cell" owner:nil options:nil] lastObject];
        }
        [cell.iconImageView setImageWithURL:[NSURL URLWithString:_detailModel.BookIconOtherURL]];
        cell.titleLabel.text = _detailModel.BookName;
        
        cell.typeLabel.text = [NSString stringWithFormat:@"所属类别：%@",_detailModel.CatalogName];
        cell.authorLabel.text = [NSString stringWithFormat:@"作者：%@",_detailModel.BookAuthor];
        cell.popularLabel.text = [NSString stringWithFormat:@"人气：%u",_detailModel.BookClickCount];
        cell.dateLabel.text = [NSString stringWithFormat:@"最后更新：%@",_detailModel.BookUpdateDate];
        cell.stateLabel.text = [NSString stringWithFormat:@"连载状态：%@",_detailModel.BookStateName];
        cell.descLabel.text = _detailModel.BookDescription;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        _bookName = _detailModel.BookName;

        
        return cell;
        
    }else{
        NSString * iden = @"iden";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        }
        ListModel * model = _listArray[indexPath.row-1];
        cell.textLabel.text = model.sectionName;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%u页",model.picCount];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row!=0) {
        
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListModel * model = _listArray[indexPath.row-1];
    ICShowController * icShow = [[ICShowController alloc]init];
    icShow.icId = model.sectionID;
    [self.navigationController pushViewController:icShow animated:YES];
    }
}


-(void)saveButtonClick:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"已收藏"]) {
        return;
    }
   
    [button setTitle:@"已收藏" forState:UIControlStateNormal];
    Book * icbook = [Book MR_createEntity];
    icbook.name = _urlName;
    icbook.bookID = [NSNumber numberWithInteger:_urlId];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
   
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
