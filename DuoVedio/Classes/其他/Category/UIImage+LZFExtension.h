//
//  UIImage+LZFExtension.h
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/8/17.
//  Copyright © 2016年 longroader. All rights reserved.
//  UIImage分类:可以返回一个圆形图片

#import <UIKit/UIKit.h>

@interface UIImage (LZFExtension)
/** 返回一个圆形image */
- (instancetype)lzf_circleImage;
+ (instancetype)lzf_circleImage:(NSString *)name;
/* 返回一个不被系统自动渲染的image */
+ (UIImage *)zf_imageWithRenderOriginalName:(NSString *)name;
@end


