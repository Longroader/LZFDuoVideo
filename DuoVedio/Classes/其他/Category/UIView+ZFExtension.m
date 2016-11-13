//
//  UIView+ZFExtension.m
//  百思不得姐
//
//  Created by 刘志锋 on 16/4/15.
//  Copyright © 2016年 ZF. All rights reserved.
//

#import "UIView+ZFExtension.h"

@implementation UIView (ZFExtension)

// 从和类名相同的Xib里加载数据到cell
+ (instancetype)lzf_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)setZf_size:(CGSize)zf_size
{
    CGRect frame = self.frame;
    frame.size = zf_size;
    self.frame = frame;
}

- (void)setZf_width:(CGFloat)zf_width
{
    CGRect frame = self.frame;
    frame.size.width = zf_width;
    self.frame = frame;
}

- (void)setZf_height:(CGFloat)zf_height
{
    CGRect frame = self.frame;
    frame.size.height = zf_height;
    self.frame = frame;
}

- (void)setZf_x:(CGFloat)zf_x
{
    CGRect frame = self.frame;
    frame.origin.x = zf_x;
    self.frame = frame;
}

- (void)setZf_y:(CGFloat)zf_y{
    CGRect frame = self.frame;
    frame.origin.y = zf_y;
    self.frame = frame;
}

- (void)setZf_centerX:(CGFloat)zf_centerX
{
    CGPoint center = self.center;
    center.x = zf_centerX;
    self.center = center;
}

- (void)setZf_centerY:(CGFloat)zf_centerY
{
    CGPoint center = self.center;
    center.y = zf_centerY;
    self.center = center;
}

- (CGSize)zf_size
{
    return self.frame.size;
}

- (CGFloat)zf_width
{
    return self.frame.size.width;
}

- (CGFloat)zf_height
{
    return self.frame.size.height;
}

- (CGFloat)zf_x
{
    return self.frame.origin.x;
}

- (CGFloat)zf_y
{
    return self.frame.origin.y;
}

- (CGFloat)zf_centerX
{
    return self.center.x;
}

- (CGFloat)zf_centerY
{
    return self.center.y;
}

- (CGFloat)zf_right
{
    //    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)zf_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setZf_right:(CGFloat)zf_right
{
    self.zf_x = zf_right - self.zf_width;
}

- (void)setZf_bottom:(CGFloat)zf_bottom
{
    self.zf_y = zf_bottom - self.zf_height;
}

@end
