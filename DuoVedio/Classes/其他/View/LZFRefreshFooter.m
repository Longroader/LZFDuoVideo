//
//  LZFRefreshFooter.m
//  百思不得姐练习
//
//  Created by 刘志锋 on 16/7/8.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFRefreshFooter.h"

@implementation LZFRefreshFooter
- (void)prepare
{
    [super prepare];
    self.stateLabel.textColor = [UIColor orangeColor];
    self.automaticallyHidden = YES;
    // 在这里重新设置刷新过程中的提示文字
    [self setTitle:@"正在加载更多评论..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"没有更多评论" forState:MJRefreshStateNoMoreData];
    // 控制刷新控件是否提前刷新数据以及提前多久刷新数据
//    self.triggerAutomaticallyRefreshPercent = -100;
    
    // 在MJRefreshAutoNormalFooter类型下依然可以设置取消自动刷新，默认YES
//    self.automaticallyRefresh = NO;
}
@end
