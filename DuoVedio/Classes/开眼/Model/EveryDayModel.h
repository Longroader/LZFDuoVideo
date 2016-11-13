//
//  EveryDayModel.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryDayModel : NSObject

@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSString *duration;

@property (nonatomic, strong) NSString *playUrl;

@property (nonatomic, strong) NSString *descrip;

@property (nonatomic, strong) NSString *coverBlurred;

@property (nonatomic, strong) NSString *coverForDetail;


@property (nonatomic, strong) NSNumber *collectionCount;

@property (nonatomic, strong) NSNumber *replyCount;

@property (nonatomic, strong) NSNumber *shareCount;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@end
