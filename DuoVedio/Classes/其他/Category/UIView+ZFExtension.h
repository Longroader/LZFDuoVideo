//
//  UIView+ZFExtension.h
//  百思不得姐
//
//  Created by 刘志锋 on 16/4/15.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZFExtension)
/**
 *  在分类中声明@property，只会生成方法的声明，不会生成带_下划线的成员变量和方法的实现。
 */
@property (nonatomic, assign) CGSize zf_size;
@property (nonatomic, assign) CGFloat zf_width;
@property (nonatomic, assign) CGFloat zf_height;
@property (nonatomic, assign) CGFloat zf_x;
@property (nonatomic, assign) CGFloat zf_y;
@property (nonatomic, assign) CGFloat zf_centerX;
@property (nonatomic, assign) CGFloat zf_centerY;
@property (nonatomic, assign) CGFloat zf_right;
@property (nonatomic, assign) CGFloat zf_bottom;

+ (instancetype)lzf_viewFromXib;
@end
