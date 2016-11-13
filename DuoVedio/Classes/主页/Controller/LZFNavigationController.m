//
//  LZFNavigationController.m
//  DenimDemo
//
//  Created by 刘志锋 on 16/9/8.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFNavigationController.h"
//#import "LZFWebViewController.h"
@interface LZFNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation LZFNavigationController

#pragma mark - 全屏右滑返回
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 2.创建全屏滑动手势识别器
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    // 添加手势识别器
    [self.view addGestureRecognizer:pan];
    // 设置手势识别器的代理:为了控制手势什么时候触发
    pan.delegate = self;
    // 禁用系统手势识别器
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark - 导航条返回按钮点击
- (void)backBtnClick {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
#warning gestureRecognizer:当前控制器不是根控制器时,滑动返回手势才能被触发.这是系统默认的处理方式,但是如果我们自定义了返回按钮后,就必须手动改回来. 步骤:设置手势代理->遵守协议->实现代理方法.
    return self.childViewControllers.count > 1;
}

@end
