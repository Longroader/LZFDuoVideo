//
//  LZFVVideoItem.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/20.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 
 "title":"“法鲨”主演游戏改编大片《刺客信条》最新预告"
 "image":"http://cs.vmoiver.com/Uploads/cover/2016-10-19/5806f1cdb200c_cut.jpeg"
 "rating":"7.8"
 "duration":"158",
 "publish_time":"1476856439"
 "like_num":"38",
 "share_num":"69"
 "request_url":"http://app.vmoiver.com/50239?qingapp=app_new
 "catename": "预告"
 */
@interface LZFVVideoItem : NSObject
/** 视频标题 */
@property (nonatomic, strong) NSString *title;
/** 视频封面 */
@property (nonatomic, strong) NSString *image;
/** 视频时长 */
@property (nonatomic, strong) NSString *duration;
/** 视频评分 */
@property (nonatomic, strong) NSString *rating;
/** 喜欢数 */
@property (nonatomic, strong) NSString *like_num;
/** 分享数 */
@property (nonatomic, strong) NSString *share_num;
/** 视频发布时间 */
@property (nonatomic, strong) NSString *publish_time;
/** 视频播放链接 */
@property (nonatomic, strong) NSString *request_url;

/** 视频分类数组 */
@property (nonatomic, strong) NSArray *cates;
@end
