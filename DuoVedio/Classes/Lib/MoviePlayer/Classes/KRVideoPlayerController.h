//
//  KRVideoPlayerController.h
//  KRKit
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

@import MediaPlayer;
@class KRVideoPlayerControlView;

@interface KRVideoPlayerController : MPMoviePlayerController

@property (nonatomic, strong) KRVideoPlayerControlView *videoControl;
@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)fullScreenButtonClick;
- (void)shrinkScreenButtonClick;
- (void)showInWindow;
- (void)dismiss;

@end