//
//  ContentScrollView.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "ContentScrollView.h"
#import "ImageContentView.h"
#import "EveryDayModel.h"

@interface ContentScrollView ()

@property (nonatomic ,assign ,readwrite) NSInteger currentIndex;

@end

@implementation ContentScrollView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentSize = CGSizeMake([imageArray count] * LZFScreenWidth, 0);
        
        self.bounces = NO;
        
        self.pagingEnabled = YES;
        
        self.contentOffset = CGPointMake(index * LZFScreenWidth, 0);
        
        for (int i = 0; i < [imageArray count]; i ++) {
            
            ImageContentView *sonView = [[ImageContentView alloc] initWithFrame:CGRectMake(i * LZFScreenWidth, 0, LZFScreenWidth, LZFScreenHeight) Width:35 model:imageArray[i] collor:[UIColor whiteColor]];
            
            EveryDayModel *model = [[EveryDayModel alloc] init];
            
            model = imageArray[i];
            
            [sonView.picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
            
            [self addSubview:sonView];;
        }
    }
    return self;
}

@end

