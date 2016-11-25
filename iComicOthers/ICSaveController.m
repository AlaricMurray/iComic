//
//  ICSaveController.m
//  iComic
//
//  Created by myf on 15/11/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ICSaveController.h"
#import "ICSYDetailController.h"
#import "CoreData+MagicalRecord.h"
#import "DBModel.h"
#import "Book.h"
@interface ICSaveController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)NSMutableArray * dataArray;
@property (nonatomic , strong)UITableView * tableView;
@property (nonatomic ,strong)NSMutableArray * rubArray;
@end

@implementation ICSaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}



-(void)createUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"我的收藏";
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonBack.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;

    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(0, 0, 45,45);
    [deleteButton setBackgroundImage:[[UIImage imageNamed:@"deldowncomic.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:deleteButton];
    
    NSArray * resultArray = [Book MR_findAll];
    if (resultArray == nil) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"您还没有收藏任何漫画"]];
    }else{
    for (Book * icBook in resultArray) {
        DBModel * model = [[DBModel alloc]init];
        model.bookname = icBook.name;
        model.bookid = icBook.bookID;
        [_dataArray addObject:model];
    }
       
    }
}

-(void)buttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * iden = @"icbook";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    DBModel * model = _dataArray[indexPath.row];
    cell.textLabel.text = model.bookname ;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    ICSYDetailController * detail = [[ICSYDetailController alloc]init];
    DBModel * model = _dataArray[indexPath.row];
    detail.urlId = [model.bookid integerValue];
    detail.ictag = 100;
   
    [self.navigationController pushViewController:detail animated:YES];
   
}
- (void)editButtonClick:(UIBarButtonItem *)button{
    [_tableView setEditing:!_tableView.editing animated:YES];

}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        return UITableViewCellEditingStyleDelete;
   
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        _rubArray = [NSMutableArray arrayWithArray:_dataArray];
       [_dataArray removeObjectAtIndex:indexPath.row];
        DBModel * model = _rubArray[indexPath.row];
        NSArray * arr = [Book MR_findByAttribute:@"name" withValue:model.bookname];
        for (Book * icBook in arr) {
            [icBook MR_deleteEntity];
          
        }
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
       

        [_tableView reloadData];
    }
 
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
