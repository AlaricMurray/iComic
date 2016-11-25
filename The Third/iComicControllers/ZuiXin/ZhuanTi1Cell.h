//
//  ZhuanTi1Cell.h
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuanTi1Cell : UITableViewCell<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *icScrollView;
@property (nonatomic ,strong)NSMutableArray * dataArray;

@property (nonatomic ,strong)UIPageControl * pageControl;
@end
