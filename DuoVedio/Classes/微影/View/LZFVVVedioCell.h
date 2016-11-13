//
//  LZFVVVedioCell.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/20.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZFVVideoItem;

@interface LZFVVVedioCell : UITableViewCell

/** 视频数据模型 */
@property (nonatomic, strong) LZFVVideoItem *videoItem;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
