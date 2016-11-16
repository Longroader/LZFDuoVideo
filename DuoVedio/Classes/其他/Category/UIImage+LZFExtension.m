//
//  UIImage+LZFExtension.m
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/8/17.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "UIImage+LZFExtension.h"

@implementation UIImage (LZFExtension)
/**
 *  返回一张圆形图片
 *
 *  @return 圆形图片
 */
- (instancetype)lzf_circleImage {
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)lzf_circleImage:(NSString *)name {
    
    return [[self imageNamed:name] lzf_circleImage];
}

/**
 *  返回一张不被渲染的图片
 *  @param name 图片名字
 *  @return 不被渲染的图片
 */
+ (UIImage *)zf_imageWithRenderOriginalName:(NSString *)name {
    
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
