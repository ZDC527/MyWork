//
//  ViewController.m
//  MyWork
//
//  Created by 赵大成 on 2017/1/23.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "MWHomeVC.h"

#import "RACTestVC.h"
#import "DispatchVC.h"
#import "CompictureVC.h"
#import "UITableViewCell+reuseridentify.h"

@interface MWHomeVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UIScrollView * scrollLunch;
@property (nonatomic, strong) TimeIntervalReduceLabel * reduceLbl;
@property (nonatomic, strong) UIButton * pageTimeBtn;

@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) RACSignal * signal;
@property (nonatomic, strong) NSMutableArray * lunchData;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation MWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.topHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.listData = @[@"相册", @"dispatch", @"RAC"].mutableCopy;

    [self initData];
    [self initScrollLunch];
}

- (void)setMainView
{
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    [self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell cellReuseidentify]];
    
    [self.view addSubview:self.listTableView];
    [self.listTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
}

- (void)manageCompicture
{
    CompictureVC * vc = [[CompictureVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initScrollLunch
{
    _scrollLunch = [[UIScrollView alloc] init];
    _scrollLunch.delegate = self;
    _scrollLunch.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-self.topHeight);
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
            imageView.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.topHeight);
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
    NSLog(@"index== %ld", (long)_index);
    if (_index == _lunchData.count - 1) {
        _scrollLunch.hidden = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = scrollView.contentOffset.x/SCREEN_WIDTH;
    if (_index == _lunchData.count-1) {
        [UIView animateWithDuration:1 animations:^{
            _scrollLunch.alpha = 0;
        } completion:^(BOOL finished) {
            _scrollLunch.hidden = YES;
            [self setMainView];
        }];
        
    }
}

#pragma mark -tableView deletage
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell cellReuseidentify]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell cellReuseidentify]];
    }
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        [self manageCompicture];
    } else if (indexPath.row == 1) {
        DispatchVC *dispatch = [[DispatchVC alloc] init];
        [self.navigationController pushViewController:dispatch animated:YES];
    } else {
        RACTestVC *testVC = [[RACTestVC alloc] init];
        [self.navigationController pushViewController:testVC animated:YES];
    }
}



@end
