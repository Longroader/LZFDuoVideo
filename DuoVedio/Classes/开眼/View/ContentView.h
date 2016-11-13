//
//  ContentView.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//  点击首页视频cell后进入的页面中的文本view

#import <UIKit/UIKit.h>
@class EveryDayModel;
@interface ContentView : UIView
/** 视频封面 */
@property (nonatomic, strong) UIImageView *imageView;
/** 视频标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 视频分类/时长 */
@property (nonatomic, strong) UILabel *littleLabel;
/** 视频描述 */
@property (nonatomic, strong) UILabel *descripLabel;
/** 分割线 */
@property (nonatomic, strong) UIView *lineView;
/** 收藏数 */
@property (nonatomic, strong) UIButton *collectionBtn;
/** 分享数 */
@property (nonatomic, strong) UIButton *shareBtn;
/** 缓存数 */
@property (nonatomic, strong) UIButton *cacheBtn;
/** 评论数 */
@property (nonatomic, strong) UIButton *replyBtn;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width model:(EveryDayModel *)model collor:(UIColor *)collor;

- (void)setData:(EveryDayModel *)model;

@end
