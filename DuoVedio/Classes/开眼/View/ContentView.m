//
//  ContentView.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//  点击首页视频cell后进入视频详情页

#define LZFMargin 10
#import "ContentView.h"
#import "EveryDayModel.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width model:(EveryDayModel *)model collor:(UIColor *)collor{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 1.视频封面
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]]; // 视频封面
        [self addSubview:_imageView];
        
        // 2.视频标题
        CGFloat X = LZFMargin;
        CGFloat W = LZFScreenWidth;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, 5, W, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = collor;
        [self addSubview:_titleLabel];
        
        // 3.视频分类和时长
        _littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, 45, W, 20)];
        _littleLabel.textColor = collor;
        _littleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_littleLabel];
        
        // 4.分割线
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(X, 78, W - 2 * X, 0.5)];
        _lineView.backgroundColor = collor;
        [self addSubview:_lineView];
        
        // 5.视频描述
        _descripLabel = [[UILabel alloc]initWithFrame:CGRectMake(X, 80, W - 2 * X, 90)];
        _descripLabel.font = [UIFont systemFontOfSize:14];
        _descripLabel.numberOfLines = 0;
        _descripLabel.textColor = collor;
        [self addSubview:_descripLabel];
        
//        CGFloat Y = _descripLabel.frame.size.height + 85;
//        CGFloat CustomViewW = (W - (2 * X)) / 2 - 5;
//        CGFloat CustomViewH = 30;
        
        // 6.视频喜欢分享缓存评论等按钮
        // 喜欢按钮
        _collectionBtn = [self socialBtnWithIndex:0 image:@"twtr-icn-heart-off" selectImage:@"twtr-icn-heart-on" title:model.collectionCount.description];
        [_collectionBtn addTarget:self action:@selector(collectionClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 分享按钮
        _shareBtn = [self socialBtnWithIndex:1 image:@"twtr-share" selectImage:@"twtr-share" title:model.shareCount.description];
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 7.设置数据
        [self setData:model];
    }
    
    return self;
}

#pragma mark - 监听点击
/** 喜欢按钮点击 */
- (void)collectionClick {
    _collectionBtn.selected = !_collectionBtn.selected;
}

/** 分享按钮点击 */
- (void)shareClick {
    LZFLogFunc
    [[NSNotificationCenter defaultCenter] postNotificationName:shareClickNotification object:self];
}

#pragma mark - 创建社交按钮
- (UIButton *)socialBtnWithIndex:(NSUInteger)index image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title {
    
    CGFloat Y = _descripLabel.frame.size.height + 85;
    CGFloat CustomViewW = (LZFScreenWidth - (2 * LZFMargin)) / 2 - 5;
    CGFloat CustomViewH = 30;
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    Btn.frame = CGRectMake(CustomViewW * index + LZFMargin * (index + 1), Y, CustomViewW, CustomViewH);
    Btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    Btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [Btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    
    [self addSubview:Btn];
    
    return Btn;
}

#pragma mark - 设置视频详情页数据
- (void)setData:(EveryDayModel *)model {
    
    // 1.设置数据
    [_collectionBtn setTitle:model.collectionCount.description forState:UIControlStateNormal]; // 喜欢数
    [_shareBtn setTitle:model.shareCount.description forState:UIControlStateNormal]; // 分享数
    
    NSInteger time = [model.duration integerValue];
    NSString *timeString = [NSString stringWithFormat:@"%02ld'%02ld''",time/60,time% 60];
    NSString *string = [NSString stringWithFormat:@"#%@ / %@",model.category, timeString];
    _littleLabel.text = string; // 视频分类和时长
    _titleLabel.text = model.title; // 视频标题
    _descripLabel.text = model.descrip; // 视频简介
    
    // 3.设置文本背景模糊效果
    // [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverBlurred]];
    
    __weak typeof(self) weakSelf = self;
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.coverBlurred] options:(SDWebImageRetryFailed) progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

        if (image) {
            
            CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
            contentsAnimation.duration = 1.0f;
            contentsAnimation.fromValue = self.imageView.image ;
            contentsAnimation.toValue = image;

            contentsAnimation.removedOnCompletion = YES;
            contentsAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [weakSelf.imageView.layer addAnimation:contentsAnimation forKey:nil];

            weakSelf.imageView.image = image;
        }
    }];
}

@end
