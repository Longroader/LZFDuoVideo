//
//  LZFTabBar.m
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/5/31.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFTabBar.h"

@interface LZFTabBar()
/**
 *  发布按钮
 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation LZFTabBar

#pragma mark - 懒加载
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return  _publishButton;
}

# pragma mark - 初始化

/** 通过代码创建控件时用initWithFrame方法，此处是一次性设置底部tabBar的背景图片 **/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}
/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // NSClassFromString(@"UITabBarButton") == [UITabBarButton class]
    // NSClassFromString(@"UIButton") == [UIButton class]
    // 以上==左右两边完全等价，由于UITabBarButton是苹果内部使用的类，我们敲[UITabBarButton class]编译器会报错，所以用==左边的代码代替
    //按钮尺寸
    CGFloat buttonW = self.zf_width / 5;
    CGFloat buttonH = self.zf_height;
    CGFloat tabBarbuttonY = 0;
    //按钮索引
    int tabBarbuttonIndex = 0;
    
    /* 设置所有UITabBarButton的frame */
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        // 设置frame
        CGFloat tabBarbuttonX = tabBarbuttonIndex * buttonW;
        // 让TabBar中间留空白
        if (tabBarbuttonIndex >= 2) {
            tabBarbuttonX += buttonW;
        }
        subview.frame = CGRectMake(tabBarbuttonX, tabBarbuttonY, buttonW, buttonH);
        // 增加索引
        tabBarbuttonIndex ++;
    }
    
    /*  设置中间的发布按钮的frame  */
    self.publishButton.zf_width = buttonW;
    self.publishButton.zf_height = buttonH;
    self.publishButton.zf_centerX = self.zf_width * 0.5;
    self.publishButton.zf_centerY = self.zf_height * 0.5;
}

# pragma mark - 监听
- (void)publishClick
{
    LZFLogFunc
}

@end
