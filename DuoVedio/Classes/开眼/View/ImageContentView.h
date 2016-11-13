//
//  ImageContentView.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentView;
@class EveryDayModel;

@interface ImageContentView : UIView

@property (nonatomic, strong) UIImageView *picture;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width model:(EveryDayModel *)model collor:(UIColor *)collor;
- (void)imageOffset;

@end
