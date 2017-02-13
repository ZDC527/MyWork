//
//  UIAlignmentLabel.h
//  MyWork
//
//  Created by 赵大成 on 2017/2/13.
//  Copyright © 2017年 赵大成. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, VerticalAlignment) {
    VerticalAlignmentTop      = 0,
    VerticalAlignmentMiddle   = 1,
    VerticalAlignmentBottom   = 2
};
@interface UIAlignmentLabel : UILabel
@property (nonatomic, assign) VerticalAlignment verticalAlignment;
@end
