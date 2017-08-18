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

    [self initData];
    [self initScrollLunch];
}

- (void)initScrollLunch
{
    _scrollLunch = [[UIScrollView alloc] init];
    _scrollLunch.delegate = self;
    _scrollLunch.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    _scrollLunch.contentSize = CGSizeMake(SCREEN_WIDTH*_lunchData.count, SCREEN_HEIGHT);
    _scrollLunch.clipsToBounds = YES;
    _scrollLunch.scrollEnabled = YES;
    _scrollLunch.pagingEnabled = YES;
    _scrollLunch.bounces = YES;
    _scrollLunch.showsVerticalScrollIndicator = NO;
    
    _pageTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pageTimeBtn.frame = CGRectMake(SCREEN_WIDTH - 170, SCREEN_HEIGHT - 124, 150, 40);
    _pageTimeBtn.backgroundColor = [UIColor lightTextColor];
    [_pageTimeBtn setTitle:self.reduceLbl.text forState:UIControlStateNormal];
    [_pageTimeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_pageTimeBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    
    for (NSInteger i = 0; i < self.lunchData.count; i++) {
        NSString *imgStr = [self.lunchData objectAtIndex:i];
        if (imgStr) {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
            imageView.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [_scrollLunch addSubview:imageView];
            
            [imageView addSubview:_pageTimeBtn];
            [self reduceTime];
        }
    }
}

- (void)initData
{
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
    self.scrollLunch.contentOffset = CGPointMake(SCREEN_WIDTH*_index, 64);
}

- (void)reduceTime
{
    _reduceLbl = [[TimeIntervalReduceLabel alloc] init];
    _reduceLbl.textColor = [UIColor redColor];
    _reduceLbl.textAlignment = NSTextAlignmentCenter;
    _reduceLbl.backgroundColor = [UIColor greenColor];
//    [_reduceLbl startTimeIntervalWithStartTimeString:@"2017-02-24 17:30:00"];
    [_reduceLbl startTimeIntervalWithMillisecond:1210185];
    [_pageTimeBtn addSubview:_reduceLbl];
}

#pragma mark UISCROLLVIEWDELEGATE
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _index = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.scrollLunch.contentOffset = CGPointMake(SCREEN_WIDTH*_index, 64);
    NSLog(@"index== %ld", _index);
    if (_index == _lunchData.count - 1) {
        _scrollLunch.hidden = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = scrollView.contentOffset.x/SCREEN_WIDTH;
    if (_index == _lunchData.count-1) {
        [UIView animateWithDuration:3 animations:^{
            _scrollLunch.alpha = 0;
        } completion:^(BOOL finished) {
            _scrollLunch.hidden = YES;
        }];
        
    }
}

@end
