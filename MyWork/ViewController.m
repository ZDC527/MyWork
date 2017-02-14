//
//  ViewController.m
//  MyWork
//
//  Created by 赵大成 on 2017/1/23.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import <ReactiveCocoa.h>
#import <PureLayout.h>

#import "TimeIntervalReduceLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor magentaColor];
    
    
    [self RACButton];
    
    [self reduceTime];

    
    
}

- (void)reduceTime
{
    TimeIntervalReduceLabel * reduceLbl = [[TimeIntervalReduceLabel alloc] initWithFrame:CGRectMake(10, 90, [[UIScreen mainScreen] bounds].size.width-20, 30)];
    reduceLbl.textColor = [UIColor redColor];
    reduceLbl.textAlignment = NSTextAlignmentCenter;
    reduceLbl.backgroundColor = [UIColor greenColor];
//    [reduceLbl startTimeIntervalWithStartTimeString:@"2017-02-24 17:30:00"];
    [reduceLbl startTimeIntervalWithMillisecond:1210185];
    [self.view addSubview:reduceLbl];
}

- (void)RACButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"work" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"buttonClicked");
        NSLog(@"%@",x);
    }];
    
    [self.view addSubview:button];
    [button autoSetDimension:ALDimensionWidth toSize:100];
    [button autoSetDimension:ALDimensionHeight toSize:44];
    [button autoCenterInSuperviewMargins];
}

- (void)buttonClick
{
    NSLog(@"点击了");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
