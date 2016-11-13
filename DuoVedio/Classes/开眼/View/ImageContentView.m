//
//  ImageContentView.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "ImageContentView.h"
#import "ContentView.h"
#import "EveryDayModel.h"

@implementation ImageContentView

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width model:(EveryDayModel *)model collor:(UIColor *)collor{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        self.clipsToBounds = YES;
        _picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LZFScreenWidth, LZFScreenHeight / 1.7)];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_picture];
    }
    return self;
}

- (void)imageOffset {

    CGRect centerToWindow = [self convertRect:self.bounds toView:nil];
    CGFloat centerX = CGRectGetMidX(centerToWindow);
    CGPoint windowCenter = self.window.center;
    CGFloat cellOffsetX = centerX - windowCenter.x;
    CGFloat offsetDig =  cellOffsetX / self.window.frame.size.height * 2;

    CGAffineTransform transX = CGAffineTransformMakeTranslation(-offsetDig * LZFScreenWidth * 0.7, 0);

    self.picture.transform = transX;
}

@end
