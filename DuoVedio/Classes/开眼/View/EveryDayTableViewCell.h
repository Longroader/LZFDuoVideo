//
//  EveryDayTableViewCell.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//  首页视频cell

#import <UIKit/UIKit.h>
@class EveryDayModel;

@interface EveryDayTableViewCell : UITableViewCell
/** 视频图片 */
@property (nonatomic, strong) UIImageView *picture;
/** 视频标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 视频标签 */
@property (nonatomic, strong) UILabel *littleLabel;
/** 视频盖层 */
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) EveryDayModel *model;

- (CGFloat)cellOffset;

@end
