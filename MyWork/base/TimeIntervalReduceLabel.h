//
//  UILabel+UILabel_TimeIntervalDown.h
//  MyWork
//
//  Created by 赵大成 on 2017/2/9.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeIntervalReduceLabel : UILabel

#pragma mark 传入开始时间 字符串类型
- (void)startTimeIntervalWithStartTimeString:(NSString *)time;

#pragma mark 传入开始时间 毫秒类型
- (void)startTimeIntervalWithMillisecond:(NSTimeInterval)time;

#pragma mark 移除计时器
- (void)cancleTimeInterval;



@end
