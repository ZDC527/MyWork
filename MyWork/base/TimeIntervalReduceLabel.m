//
//  UILabel+UILabel_TimeIntervalDown.m
//  MyWork
//
//  Created by 赵大成 on 2017/2/9.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "TimeIntervalReduceLabel.h"

@interface TimeIntervalReduceLabel ()
@property (nonatomic, strong) NSTimer * mTimer;

@property (nonatomic, copy) NSDate * activityEndTime;
@property (nonatomic, assign) NSTimeInterval timeInterverl;

@end

@implementation TimeIntervalReduceLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initMTimer
{
    if (!self.mTimer) {
        self.mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.mTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)startTimeIntervalWithStartTimeString:(NSString *)time
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    formatter.timeZone = [NSTimeZone localTimeZone];
    self.activityEndTime = [formatter dateFromString:time];
    [self tranceTime];
}

- (void)startTimeIntervalWithMillisecond:(NSTimeInterval)time
{
    self.timeInterverl = time;
    [self tranceTime];
}

- (void)tranceTime
{
    [self initMTimer];
}

- (void)timeFireMethod
{
    if (self.activityEndTime) {
        self.timeInterverl = [self.activityEndTime timeIntervalSinceDate:[NSDate date]];
    } else {
        self.timeInterverl--;
    }
        
    if (self.timeInterverl < 0) {
        [self.mTimer invalidate];
        [self setMTimer:nil];
        [self activityEndTime];
    } else {
        self.text = [NSString stringWithFormat:@"%@", [self timeStringFromInterval:self.timeInterverl]];
    }
}

/**
 *  功能：根据时间计算出显示格式
 */
- (NSString *)timeStringFromInterval:(NSTimeInterval)aInterval
{
    int hours = (int)(aInterval / (60 * 60));
    int days = hours/24;
    int traceHours = hours % 24;
    aInterval -= hours * (60 * 60);
    int minutes = (int)(aInterval / 60);
    aInterval -= minutes * 60;
    int seconds =  (int)aInterval % 60;
    
    if (days >= 1) {
        return [NSString stringWithFormat:@"%d天 %02d:%02d:%02d", days, traceHours, minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%02d:%02d:%02d", traceHours, minutes, seconds];
    }
}

- (void)cancleTimeInterval
{
    if (self.mTimer) {
        [self.mTimer invalidate];
        [self setMTimer:nil];
    }
}

- (void)activityEnd
{
 
}

@end
