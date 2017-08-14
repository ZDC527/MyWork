//
//  ViewController.m
//  MyWork
//
//  Created by 赵大成 on 2017/1/23.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "MWHomeVC.h"

#import "RACTestVC.h"


@interface MWHomeVC ()

@property (nonatomic, strong) UIButton * popBtn;

@property (nonatomic, strong) RACSignal * signal;

@end

@implementation MWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor magentaColor];
    
    
    [self RACButton];
    
    [self reduceTime];

    [self.view addSubview:self.popBtn];
    
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
        
        _signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"1"];
            [subscriber sendCompleted];
            NSLog(@"signal初始化");
            return nil;
        }];
        [_signal subscribeNext:^(id  _Nullable x) {
            if ([x boolValue]) {
                button.backgroundColor = [UIColor greenColor];
            } else {
                button.backgroundColor = [UIColor yellowColor];
            }
        } completed:^{
            RACTestVC * vc = [RACTestVC new];
            vc.signal = _signal;
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"执行结束");
        }];
    }];
    
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"x==%@",x);
//    } completed:^{
//        [self popSlowSpaceAnimation:button];
//        NSLog(@"方法调用了");
//    }];
    
    [self.view addSubview:button];
    [button autoSetDimension:ALDimensionWidth toSize:100];
    [button autoSetDimension:ALDimensionHeight toSize:44];
    [button autoCenterInSuperviewMargins];
}

- (void)buttonClick
{
    NSLog(@"点击了");
}

- (UIButton *)popBtn
{
    if (_popBtn == nil) {
        _popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _popBtn.frame = CGRectMake(100, 200, 80, 50);
        [_popBtn setTitle:@"click" forState:UIControlStateNormal];
        [_popBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_popBtn setBackgroundColor:[UIColor redColor]];
        [_popBtn addTarget:self action:@selector(popButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_popBtn addGestureRecognizer:pan];
    }
    return _popBtn;
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        POPDecayAnimation * animation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        animation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:animation forKey:@"decay"];
    }
}

- (void)popButtonClick
{
    //减速
    //    [self popSlowSpaceAnimation:self.popBtn];
    
    [self popSpringAnimation:self.popBtn];
}

/**
 衰减效果
 
 @param button 载体
 */
- (void)popSlowSpaceAnimation:(UIButton*)button
{
    POPBasicAnimation * animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    animation.duration = 3.0;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 100)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [button.layer pop_addAnimation:animation forKey:@"pop"];
    
    [self performSelector:@selector(remomvePOP:) withObject:nil afterDelay:1.5];
}

/**
 弹簧效果
 
 @param button 实现动画的载体
 */
- (void)popSpringAnimation:(UIButton*)button
{
    POPSpringAnimation * animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    animation.springSpeed = 6.0;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 90)];
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            button.frame = CGRectMake(0, 0, 100, 45);
            button.center = self.view.center;
        }
    };
    [button.layer pop_addAnimation:animation forKey:nil];
}

- (void)remomvePOP:(UIButton*)sender
{
    [sender.layer pop_removeAnimationForKey:@"pop"];
}








@end
