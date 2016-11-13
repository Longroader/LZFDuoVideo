//
//  rilegouleView.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentView;
@class ContentScrollView;
@class EveryDayTableViewCell;

@interface rilegouleView : UIView
@property (nonatomic, strong) ContentView *contentView;

@property (nonatomic, strong) ContentScrollView *scrollView;

@property (nonatomic, strong)  EveryDayTableViewCell *animationView;

@property (nonatomic ,strong) UIImageView *playView;

@property (nonatomic ,assign) NSInteger currentIndex;

@property (nonatomic ,assign) CGFloat offsetY;

@property (nonatomic ,assign) CGAffineTransform animationTrans;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index;
- (void)aminmationShow;
- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete;

@end
