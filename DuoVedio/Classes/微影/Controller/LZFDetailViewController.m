//
//  LZFDetailViewController.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/21.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFDetailViewController.h"
#import "KRVideoPlayerController.h"

@interface LZFDetailViewController ()

/** 播放器 */
@property (nonatomic, strong) KRVideoPlayerController *videoController;
/** 系统观察者 */
@property (nonatomic, weak) id observer;

@end

@implementation LZFDetailViewController

#pragma mark - 懒加载
- (KRVideoPlayerController *)videoController {
    
    if (_videoController == nil) {
        // 设置播放器frame
        CGFloat playerWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat playerHeight = playerWidth * (9.0 / 16.0);
        _videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 20, playerWidth, playerHeight)];
    }
    
    return _videoController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 进入网页时隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 退出网页时显示导航条
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 关闭播放器
//    [self.videoController dismiss];
    [UIView animateWithDuration:0.25 animations:^{
        self.videoController.view.transform = CGAffineTransformMakeTranslation(self.view.zf_width, 0);
    } completion:^(BOOL finished) {
        
        [self.videoController dismiss];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    
    [self.videoController showInWindow];
    
//    [self.view addSubview:self.videoController.view];
    
    // 监听播放器关闭按钮点击
    _observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"closeButtonClick" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:_observer];
}

@end
