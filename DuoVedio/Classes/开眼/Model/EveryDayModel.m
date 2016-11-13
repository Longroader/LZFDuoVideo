//
//  EveryDayModel.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/16.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "EveryDayModel.h"

@implementation EveryDayModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.descrip = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        
        self.ID = [value stringValue];
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"duration"]) {
        
        self.duration = [value stringValue];
    }
    
    //    if ([key isEqualToString:@"collectionCount"]) {
    //
    //        self.collectionCount = [value stringValue];
    //
    //    }
    //
    //    if ([key isEqualToString:@"replyCount"]) {
    //
    //        self.replyCount = [value stringValue];
    //
    //    }
    //
    //    if ([key isEqualToString:@"shareCount"]) {
    //
    //        self.shareCount = [value stringValue];
    //        
    //    }
}

@end
