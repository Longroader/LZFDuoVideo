//
//  EveryDayTableViewCell.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//  首页视频cell

#import "EveryDayTableViewCell.h"
#import "EveryDayModel.h"

@implementation EveryDayTableViewCell

#pragma mark - 初始化自定义cell外观
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // cell外观
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.clipsToBounds = YES;
        // 视频封面图片
        _picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(LZFScreenHeight / 1.7 - cellHeight) / 2, LZFScreenWidth, LZFScreenHeight / 1.7)];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView  addSubview:_picture];
        // 视频封面蒙版
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LZFScreenWidth, cellHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
        [self.contentView addSubview:_coverView];
        // 视频标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cellHeight * 0.5 - 20, LZFScreenWidth, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        // 视频标签/时长
        _littleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cellHeight * 0.5 + 10, LZFScreenWidth, 30)];
        _littleLabel.font = [UIFont systemFontOfSize:14];
        _littleLabel.textAlignment = NSTextAlignmentCenter;
        _littleLabel.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_littleLabel];
    }
    
    return self;
}

#pragma mark - 设置cell数据
- (void)setModel:(EveryDayModel *)model{
    
    if (_model != model) {
        
        [_picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:[UIImage imageNamed:@"Video_Bg"]];
        _titleLabel.text = model.title;
        
        // 模型时长对象数据 -> int类型数据
        NSInteger time = [model.duration integerValue];
        // 视频时长(分秒转换)
        NSString *timeString = [NSString stringWithFormat:@"%.2ld'%.2ld''", time / 60, time % 60];
        // 拼接标签/时长字符串
        NSString *string = [NSString stringWithFormat:@"#%@ / %@", model.category, timeString];
        
        _littleLabel.text = string;
    }
}

#pragma mark - 设置cell偏移量
- (CGFloat)cellOffset {

    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;

    CGFloat cellOffsetY = centerY - windowCenter.y;

    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset =  -offsetDig * (LZFScreenHeight / 1.7 - 250) / 2;

    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    
    self.picture.transform = transY;
    // 设置文字随滚动发生偏移
    // self.titleLabel.transform = transY;
    // self.littleLabel.transform = transY;
    return offset;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
