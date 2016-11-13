//
//  LZFCover.m
//  彩票
//
//  Created by LZF on 14/10/24.
//  Copyright © 2014年 longroader. All rights reserved.
//

#define LZFKeyWindow [UIApplication sharedApplication].keyWindow

#import "LZFCover.h"

@implementation LZFCover
/**
 *  预制蒙版
 */
+ (void)show {
    // 创建蒙版
    LZFCover *cover = [[LZFCover alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
    
    // 添加蒙版
    [LZFKeyWindow addSubview:cover];
}

/**
 *  自定义背景色蒙版
 *
 *  @param color 自定义颜色
 */
+ (void)showWithColor:(UIColor *)color {
    // 创建蒙版
    LZFCover *cover = [[LZFCover alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = color;
    
    // 添加蒙版
    [LZFKeyWindow addSubview:cover];
}

/**
 *  自定义背景图片蒙版
 *
 *  @param image 自定义图片
 */
+ (void)showWithImage:(UIImage *)image {
    
    // 创建蒙版
    LZFCover *cover = [[LZFCover alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    
    UIImageView *coverImageView = [[UIImageView alloc] initWithImage:image];
    coverImageView.center = cover.center;
    [cover addSubview:coverImageView];
    
    // 添加蒙版
    [LZFKeyWindow addSubview:cover];
}

/**
 *  隐藏蒙版
 */
+ (void)dismiss {
    
    for (UIView *view in LZFKeyWindow.subviews) { // 遍历主窗口找到LZFCover并移除
        if ([view isKindOfClass:[LZFCover class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

@end