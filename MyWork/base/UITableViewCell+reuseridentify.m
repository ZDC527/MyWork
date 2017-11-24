//
//  UITableViewCell+reuseridentify.m
//  MyWork
//
//  Created by 赵大成 on 2017/11/23.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import "UITableViewCell+reuseridentify.h"

@implementation UITableViewCell (reuseridentify)

+ (NSString *)cellReuseidentify
{
    NSString *identify = [NSString stringWithFormat:@"%@", [self class]];
    
    return identify;
}

@end
