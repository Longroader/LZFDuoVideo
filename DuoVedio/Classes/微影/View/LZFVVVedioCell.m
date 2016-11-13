//
//  LZFVVVedioCell.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/20.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFVVVedioCell.h"
#import "LZFVVideoItem.h"
#import <UIImageView+WebCache.h>

@interface LZFVVVedioCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image_view; // 视频封面
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; // 视频标题
@property (weak, nonatomic) IBOutlet UILabel *durationLabel; // 视频时长

@end

@implementation LZFVVVedioCell

static NSString * const videoCellID = @"videoCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    LZFVVVedioCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/** 设置数据 */
- (void)setVideoItem:(LZFVVideoItem *)videoItem {
    
    _videoItem = videoItem;
    // 设置封面
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:videoItem.image] placeholderImage:[UIImage imageNamed:@"Video_Bg"]];
    // 设置标题
    self.titleLabel.text = videoItem.title;
    
    NSDictionary *cates = videoItem.cates.firstObject;
    NSString *catename = cates[@"catename"];
    // 设置时长
    int durition = [videoItem.duration intValue];
    self.durationLabel.text = [NSString stringWithFormat:@"%@ | %02d'%02d''", catename, durition / 60, durition % 60];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

@end
