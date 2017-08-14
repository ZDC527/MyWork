//
//  RACTestVC.m
//  MyWork
//
//  Created by 赵大成 on 2017/8/14.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "RACTestVC.h"

@interface RACTestVC ()

@end

@implementation RACTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_signal subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            self.view.backgroundColor = [UIColor greenColor];
        } else {
            self.view.backgroundColor = [UIColor yellowColor];
        }
    } completed:^{
        NSLog(@"执行结束");
    }];
    
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
