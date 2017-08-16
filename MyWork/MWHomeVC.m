//
//  ViewController.m
//  MyWork
//
//  Created by 赵大成 on 2017/1/23.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "MWHomeVC.h"

#import "RACTestVC.h"


@interface MWHomeVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollLunch;
@property (nonatomic, strong) TimeIntervalReduceLabel * reduceLbl;
@property (nonatomic, strong) UIButton * pageTimeBtn;

@property (nonatomic, strong) RACSignal * signal;
@property (nonatomic, strong) NSMutableArray * lunchData;
@property (nonatomic, assign) NSInteger index;
@end

@implementation MWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    [self reduceTime];

    [self initData];
    [self initScrollLunch];
}

- (void)initScrollLunch
{
    _scrollLunch = [[UIScrollView alloc] init];
    _scrollLunch.delegate = self;
    _scrollLunch.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollLunch.contentSize = CGSizeMake(SCREEN_WIDTH * self.lunchData.count, SCREEN_HEIGHT);
    _scrollLunch.scrollEnabled = YES;
    _scrollLunch.pagingEnabled = YES;
    
    _pageTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pageTimeBtn.frame = CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 60, 80, 40);
    _pageTimeBtn.backgroundColor = [UIColor lightTextColor];
    [_pageTimeBtn setTitle:self.reduceLbl.text forState:UIControlStateNormal];
    [_pageTimeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_pageTimeBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [_scrollLunch addSubview:_pageTimeBtn];
    
    for (NSInteger i = 0; i < self.lunchData.count; i++) {
        NSString *imgStr = [self.lunchData objectAtIndex:i];
        if (imgStr) {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
            imageView.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [_scrollLunch addSubview:imageView];
        }
    }
}

- (void)initData
{
    ///Users/ZDC/MyWork/MyWork/lunch
//    NSString * lunchPath = [[NSBundle mainBundle]pathForResource:@"lunch" ofType:@"bundle"];
//    
//    self.lunchData = [[NSMutableArray alloc] initWithContentsOfFile:lunchPath];
    self.lunchData = @[@"l1.jpg",@"l2.jpg",@"l3.jpg"].mutableCopy;
}

- (void)showLunchView
{
    [self.view addSubview:self.scrollLunch];
    
}

- (void)nextPage
{
    if (_index == self.lunchData.count) {
        self.scrollLunch.hidden = YES;
        
        return;
    }
    if (_index < self.lunchData.count) {
        _index += 1;
    }
    self.scrollLunch.contentOffset = CGPointMake(SCREEN_WIDTH*_index, 0);
}

- (void)reduceTime
{
    _reduceLbl = [[TimeIntervalReduceLabel alloc] initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH-20, 30)];
    _reduceLbl.textColor = [UIColor redColor];
    _reduceLbl.textAlignment = NSTextAlignmentCenter;
    _reduceLbl.backgroundColor = [UIColor greenColor];
//    [reduceLbl startTimeIntervalWithStartTimeString:@"2017-02-24 17:30:00"];
    [_reduceLbl startTimeIntervalWithMillisecond:1210185];
    [self.scrollLunch addSubview:_reduceLbl];
}

#pragma mark UISCROLLVIEWDELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _index = scrollView.contentOffset.y/SCREEN_WIDTH;
    
    NSLog(@"index== %ld", _index);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}



@end
