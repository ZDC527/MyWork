//
//  DispatchVC.m
//  MyWork
//
//  Created by 赵大成 on 2017/11/23.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "DispatchVC.h"

@interface DispatchVC ()

@end

@implementation DispatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeQueue];
    
}

//串行队列和并行队列的创建
- (void)makeQueue
{
    //DISPATCH创建串行队列
    DISPATCH_QUEUE_SERIAL;//串行，等待当前任务之行结束再执行下边的任务
    DISPATCH_QUEUE_CONCURRENT;//并行，不等现在执行中的处理结束就可以执行其他的处理，只有在异步处理中才能体现并发的特性
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.ks.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrent = dispatch_queue_create("com.ks.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    //同步执行，不创建新的线程
    dispatch_sync(serialQueue, ^{
        NSLog(@"serialAueue--%@--%@", DISPATCH_CURRENT_QUEUE_LABEL, [NSThread currentThread]);
    });
    
    //异步执行， 创建新的线程
    dispatch_async(concurrent, ^{
        NSLog(@"concurrentQueue--%@--%@", DISPATCH_CURRENT_QUEUE_LABEL, [NSThread currentThread]);
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
