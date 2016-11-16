//
//  LZFTabBarController.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/15.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFTabBarController.h"
#import "LZFKKViewController.h"
#import "LZFVVViewController.h"
#import "LZFNavigationController.h"

@interface LZFTabBarController ()

@end

@implementation LZFTabBarController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置状态栏 ****/
    [self setupStatus];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
    /**** 添加子控制器 ****/
    [self setupChildViewcontrollors];
    
    /**** 更换TabBar ****/
    // [self setupTabBar];
}

- (void)setupStatus {
    
    // 启动后显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor cyanColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage zf_imageWithRenderOriginalName:image];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    vc.tabBarItem.selectedImage = [UIImage zf_imageWithRenderOriginalName:selectedImage];
    
    [self addChildViewController:vc];
}

/** 设置子控制器 */
- (void)setupChildViewcontrollors
{
    
    [self setupOneChildViewController:[[LZFNavigationController alloc] initWithRootViewController:[[LZFKKViewController alloc] init]] title:nil image:@"ic_tab_1_49x49_" selectedImage:@"ic_tab_1_selected_49x49_"];
    
    [self setupOneChildViewController:[[LZFNavigationController alloc] initWithRootViewController:[[LZFVVViewController alloc] init]] title:nil image:@"ic_tab_2_49x49_" selectedImage:@"ic_tab_2_selected_49x49_"];
}

@end
