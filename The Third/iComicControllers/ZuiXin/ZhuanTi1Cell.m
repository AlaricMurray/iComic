//
//  ZhuanTi1Cell.m
//  iComic
//
//  Created by myf on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZhuanTi1Cell.h"
#import "ICFunction.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "SrollModel.h"
@implementation ZhuanTi1Cell

- (void)awakeFromNib {
    // Initialization code
    [self sendRequest];
}



-(void)createUI{
    
    for (int i = 0; i<_dataArray.count; i++) {
        UIImageView * icimageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.icScrollView.frame.size.width * i, 0, [[UIScreen mainScreen]bounds].size.width, self.icScrollView.frame.size.height)];
        SrollModel * model = _dataArray[i];
        [icimageView setImageWithURL:[NSURL URLWithString:model.TopicIconUrl]];
       
        [_icScrollView addSubview:icimageView];
        
        UILabel * iclabel = [[UILabel alloc]initWithFrame:CGRectMake(self.icScrollView.frame.size.width * i, self.icScrollView.frame.size.height-30, [[UIScreen mainScreen]bounds].size.width, 30)];
        iclabel.backgroundColor = [UIColor blackColor];
        iclabel.textColor = [UIColor whiteColor];
        iclabel.text = [NSString stringWithFormat:@"    %@",model.TopicName];
        iclabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        [_icScrollView addSubview:iclabel];
        
        
    }
    _icScrollView.delegate = self;
    _icScrollView.contentSize = CGSizeMake(10+[[UIScreen mainScreen]bounds].size.width*_dataArray.count, 75);
    _icScrollView.pagingEnabled = YES;
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.icScrollView.frame.size.width-90, self.icScrollView.frame.size.height-30, 90, 30)];
    
    _pageControl.backgroundColor = [UIColor clearColor];
     _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
      _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    _pageControl.numberOfPages = _dataArray.count;
    [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_pageControl];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pageChange) userInfo:nil repeats:YES];

}

-(void)pageChange{
    
    
     static int i = 0;
    if (i == _dataArray.count) {
        _icScrollView.contentOffset = CGPointMake(0, 0);
        _pageControl.currentPage = 0;
        i=0;
    }
    [UIView animateWithDuration:1 animations:^{
        _icScrollView.contentOffset = CGPointMake(self.icScrollView.frame.size.width*i, 0);
        CGPoint point = _icScrollView.contentOffset;
        _pageControl.currentPage = point.x/_icScrollView.frame.size.width;
        }];
    
    i++;
    
}
-(void)pageControlChanged:(UIPageControl *)pageControl{
    
    int i = pageControl.currentPage;
    if (i==5) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _icScrollView.contentOffset = CGPointMake(0,0);
        }];
        CGPoint point = _icScrollView.contentOffset;
      int i = point.x/_icScrollView.frame.size.width;
        pageControl.currentPage = i;
    }
    else{
        
        [UIView animateWithDuration:0.5 animations:^{
            _icScrollView.contentOffset = CGPointMake(_icScrollView.frame.size.width * i,0);
        }];
        CGPoint point = _icScrollView.contentOffset;
          int i = point.x/_icScrollView.frame.size.width;
        pageControl.currentPage = i;
    }

}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
      int i = point.x/_icScrollView.frame.size.width;
    _pageControl.currentPage = i;
   
}

-(void)sendRequest{
    
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [ICFunction getHttpURL:nil andWithUrl:GUNDONG andWithType:@"text/plain" completation:^(id object) {
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray * icArray = [NSArray arrayWithArray:object];
            for (NSDictionary * dict in icArray) {
                SrollModel * model = [[SrollModel alloc]init];
                [model setSrollValuesByDictionary:dict];
                [_dataArray addObject:model];
                
            }
            [self createUI];
            
        }
        
    } failure:^(NSError *error) {
        [ICFunction FailtoConnection];
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
