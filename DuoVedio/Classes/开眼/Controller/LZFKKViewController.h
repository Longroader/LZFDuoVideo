//
//  LZFKKViewController.h
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/15.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import <UIKit/UIKit.h>
@class rilegouleView;

@interface LZFKKViewController : UITableViewController

@property (nonatomic, strong) rilegouleView *rilegoule;

@property (nonatomic, strong) UIImageView *BlurredView;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
