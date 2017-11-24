//
//  PaiXuVC.m
//  MyWork
//
//  Created by 赵大成 on 2017/11/24.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "PaiXuVC.h"

@interface PaiXuVC ()

@end

@implementation PaiXuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self maoPao];
    
}

- (void)maoPao
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"3",@"1",@"10",@"5",@"2",@"7",@"12",@"4",@"8"]];
    
    for (int i =0; i < array.count;i ++) {
        for (int j =0; j < array.count -1 - i; j++) {
            if([[array objectAtIndex:j]integerValue] > [[array objectAtIndex:j + 1]integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
        NSLog(@"%@",array);
    }
}

@end
