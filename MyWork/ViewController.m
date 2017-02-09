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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor magentaColor];
    
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
