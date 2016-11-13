//
//  LZFCover.h
//  彩票
//
//  Created by LZF on 14/10/24.
//  Copyright © 2014年 longroader. All rights reserved.
//  蒙版

#import <UIKit/UIKit.h>

@interface LZFCover : UIView
+ (void)show;
+ (void)showWithColor:(UIColor *)color;
+ (void)showWithImage:(UIImage *)image;
+ (void)dismiss;
@end
