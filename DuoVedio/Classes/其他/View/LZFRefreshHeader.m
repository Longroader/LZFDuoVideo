//
//  LZFRefreshHeader.m
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/7/6.
//  Copyright © 2016年 longroader. All rights reserved.
//  自定义下拉刷新headerView

#import "LZFRefreshHeader.h"

@interface LZFRefreshHeader()
/** logo */
@property (nonatomic, weak) UIImageView *logo;
@end

@implementation LZFRefreshHeader

/** 初始化 */
- (void)prepare
{
    [super prepare];
    
    self.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
    self.stateLabel.textColor = [UIColor darkGrayColor];
    self.automaticallyChangeAlpha = YES;
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"客官请松手" forState:MJRefreshStatePulling];
    [self setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
//    self.arrowView.hidden = YES;
//    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
//    [self addSubview:[[UISwitch alloc] init]];
    
    // 刷新控件背景
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"more"];
    [self addSubview:logo];
    self.logo = logo;
}

/** 摆放子控件 */
- (void)placeSubviews
{
    [super placeSubviews];
    [self.logo sizeToFit];
    self.logo.mj_origin = CGPointMake(0, -14);
    self.logo.zf_centerX = self.zf_centerX;
}

@end
