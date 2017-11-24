//
//  SuanFaVC.m
//  MyWork
//
//  Created by 赵大成 on 2017/11/24.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "SuanFaVC.h"

@interface SuanFaVC ()

@end

@implementation SuanFaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self applicationPath];
}

- (void)applicationPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"paths==%@", paths);
    
    NSString *documentsDirectory = [paths firstObject];
    //创建文件系统管理器
    NSFileManager *manager = [[NSFileManager alloc] init];
    //判断 userData 目录是否存在
    NSString *userPath = [NSString stringWithFormat:@"%@/userData/", documentsDirectory];
    if (![manager fileExistsAtPath:userPath]) {
        //不存在，就创建一个
        [manager createDirectoryAtPath:userPath withIntermediateDirectories:false attributes:nil error:nil];
    }
    NSLog(@"file==%@", manager);
    
    //同步队列是把一个任务添加到队列后立马就执行；而并发队列不会。
    
}

@end
