//
//  LZFKKViewController.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/15.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFKKViewController.h"
#import "EveryDayModel.h"
#import "EveryDayTableViewCell.h"
#import "ContentScrollView.h"
#import "ContentView.h"
#import "rilegouleView.h"
#import "ImageContentView.h"
#import "KRVideoPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MJRefresh.h>
#import "LZFRefreshHeader.h"
#import "LZFCover.h"

@interface SDWebImageManager  (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url;

@end

@implementation SDWebImageManager (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url {
    
    NSString *key = [self cacheKeyForURL:url];
    return ([self.imageCache imageFromMemoryCacheForKey:key] != nil) ?  YES : NO;
}

@end

@interface LZFKKViewController ()
/** 系统通知中心观察者 */
@property (nonatomic, weak) id observer;
@property (nonatomic, retain) NSMutableDictionary *selectDic;

@property (nonatomic, retain) NSMutableArray *dateArray;

@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation LZFKKViewController

static NSString * const EveryDayCellID = @"EveryDayCell";

#pragma mark - 生命周期开始
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase]; // 基本设置
    
    [self jsonSelection]; // Json数据解析
    
    [self setupRefresh];
    
    [self dealNotifications]; // 处理通知

}

#pragma mark - 生命周期结束
- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:_observer];
}

#pragma mark - 基本设置
- (void)setupBase {
    
    self.navigationItem.title = @"每日精彩·短视频";
    self.tableView.rowHeight = cellHeight;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[EveryDayTableViewCell class] forCellReuseIdentifier:EveryDayCellID];
}

#pragma mark - 处理分享按钮点击通知
- (void)dealNotifications {
    
    _observer = [[NSNotificationCenter defaultCenter] addObserverForName:shareClickNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        // 弹出社交分享视图
        UIAlertController *shareAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [shareAlert addAction:[UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LZFLog(@"分享到【微信好友】");
        }]];
        [shareAlert addAction:[UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LZFLog(@"分享到【朋友圈】");
        }]];
        [shareAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:shareAlert animated:YES completion:nil];
    }];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)selectDic{
    
    if (!_selectDic) {
        _selectDic = [[NSMutableDictionary alloc]init];
    }
    return _selectDic;
}
- (NSMutableArray *)dateArray{
    
    if (!_dateArray) {
        _dateArray = [[NSMutableArray alloc]init];
    }
    return _dateArray;
}

- (KRVideoPlayerController *)videoController {
    
    if (_videoController == nil) {
        // 设置播放器frame
        CGFloat playerWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat playerHeight= playerWidth*(9.0/16.0);
        _videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 20, playerWidth, playerHeight)];
    }
    
    return _videoController;
}
#pragma mark - 刷新
- (void)setupRefresh {
    
    // 1.创建下拉刷新
    self.tableView.mj_header = [LZFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(jsonSelection)];
    
    // 2.默认下拉刷新一次
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 数据解析
- (void)jsonSelection{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // 创建日期格式化类对象
    dateFormatter.dateFormat = @"yyyyMMdd"; // 设置日期格式
    
    NSDate *date = [NSDate date]; // 返回当前日期
    NSString *dateString = [dateFormatter stringFromDate:date]; //将当前时间转换为字符串对象
    NSString *url = [NSString stringWithFormat:kEveryDay, dateString]; //将当前日期传入url
    
    [LORequestManger GET:url success:^(id response) {
        
        NSDictionary *Dic = (NSDictionary *)response; // 1.请求返回字典
        
        NSArray *array = Dic[@"dailyList"]; // 2.取出字典中dailyList对应的数组
        
        for (NSDictionary *dic in array) { // 3.遍历dailyList数组中的字典
            
            NSMutableArray *selectArray = [NSMutableArray array];
            
            NSArray *arr = dic[@"videoList"]; // 4.取出字典中videoList对应的数组
            
            for (NSDictionary *dic1 in arr) { // 5.再遍历videoList数组中的字典
                // 字典 -> 模型
                EveryDayModel *model = [[EveryDayModel alloc] init];
                [model setValuesForKeysWithDictionary:dic1];
                
                model.collectionCount = dic1[@"consumption"][@"collectionCount"];
                model.replyCount = dic1[@"consumption"][@"replyCount"];
                model.shareCount = dic1[@"consumption"][@"shareCount"];
                
                // 将转换好的模型添加到数组
                [selectArray addObject:model];
            }
            
            NSString *date = [[dic[@"date"] stringValue] substringToIndex:10];
            
            [self.selectDic setValue:selectArray forKey:date];
        }
        
        NSComparisonResult (^priceBlock)(NSString *, NSString *) = ^(NSString *string1, NSString *string2){
            
            NSInteger number1 = [string1 integerValue];
            NSInteger number2 = [string2 integerValue];
            
            if (number1 > number2) {
                return NSOrderedAscending;
            }else if(number1 < number2){
                return NSOrderedDescending;
            }else{
                return NSOrderedSame;
            }
        };
        
        self.dateArray = [[[self.selectDic allKeys] sortedArrayUsingComparator:priceBlock] mutableCopy];
        
//        NSLog(@"%ld",[self.dateArray count]);
        
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        LZFLog(@"%@",error);
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
    }];
}

#pragma mark - TableView数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.selectDic[self.dateArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EveryDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EveryDayCellID forIndexPath:indexPath];
    
    return cell;
}

//添加每个cell出现时的3D动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(EveryDayTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EveryDayModel *model = self.selectDic[self.dateArray[indexPath.section]][indexPath.row];
    
    if (![[SDWebImageManager sharedManager] memoryCachedImageExistsForURL:[NSURL URLWithString:model.coverForDetail]]) {
        
        CATransform3D rotation; //3D旋转
        
        rotation = CATransform3DMakeTranslation(0 ,50 ,20);
        // rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
        // 逆时针旋转
        rotation = CATransform3DScale(rotation, 0.9, .9, 1);
        rotation.m34 = 1.0/ -600;
        
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        cell.layer.transform = rotation;
        
        [UIView beginAnimations:@"rotation" context:NULL];
        //旋转时间
        [UIView setAnimationDuration:0.6];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
    
    [cell cellOffset];
    
    cell.model = model;
}


#pragma mark - 单元格代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showImageAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_rilegoule.scrollView]) {
        
        for (ImageContentView *subView in scrollView.subviews) {
            
            if ([subView respondsToSelector:@selector(imageOffset)] ) {
                [subView imageOffset];
            }
        }
        
        CGFloat x = _rilegoule.scrollView.contentOffset.x;
        
        CGFloat off = ABS( ((int)x % (int)LZFScreenWidth) - LZFScreenWidth / 2) / (LZFScreenWidth / 2) + 0.2;
        
        [UIView animateWithDuration:2.0 animations:^{
            _rilegoule.playView.alpha = off;
            _rilegoule.contentView.titleLabel.alpha = off + 0.3;
            _rilegoule.contentView.littleLabel.alpha = off + 0.3;
            _rilegoule.contentView.lineView.alpha = off + 0.3;
            _rilegoule.contentView.descripLabel.alpha = off + 0.3;
            _rilegoule.contentView.collectionBtn.alpha = off + 0.3;
            _rilegoule.contentView.shareBtn.alpha = off + 0.3;
            _rilegoule.contentView.cacheBtn.alpha = off + 0.3;
            _rilegoule.contentView.replyBtn.alpha = off + 0.3;
            
        }];
        
    } else {
        
        NSArray<EveryDayTableViewCell *> *array = [self.tableView visibleCells];
        
        [array enumerateObjectsUsingBlock:^(EveryDayTableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj cellOffset];
        }];
        
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if(velocity.y > 0) { // 加速度 > 0 时隐藏导航条
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    } else {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_rilegoule.scrollView]) {
        
        int index = floor((_rilegoule.scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
        
        _rilegoule.scrollView.currentIndex = index;
        
        self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:self.currentIndexPath.section];
        
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
        
        [self.tableView setNeedsDisplay];
        EveryDayTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        
        [cell cellOffset];
        
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        _rilegoule.animationTrans = cell.picture.transform;
        _rilegoule.offsetY = rect.origin.y;
        
        EveryDayModel *model = _array[index];
        
        [_rilegoule.contentView setData:model];
        
        [_rilegoule.animationView.picture setImageWithURL:[NSURL URLWithString: model.coverForDetail]];
        
    }
}

#pragma mark - 设置待播放界面
- (void)showImageAtIndexPath:(NSIndexPath *)indexPath {
    // 动画隐藏tabBar
    [UIView animateWithDuration:0.3f animations:^{

        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
    }];
    
    _array = _selectDic[_dateArray[indexPath.section]];
    _currentIndexPath = indexPath;
    
    EveryDayTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    CGFloat y = rect.origin.y;
    
    _rilegoule = [[rilegouleView alloc] initWithFrame:CGRectMake(0, 0, LZFScreenWidth, LZFScreenHeight) imageArray:_array index:indexPath.row];
    _rilegoule.offsetY = y;
    _rilegoule.animationTrans = cell.picture.transform;
    _rilegoule.animationView.picture.image = cell.picture.image;
    
    _rilegoule.scrollView.delegate = self;
    
    [[self.tableView superview] addSubview:_rilegoule];
    
    //添加轻扫手势
    UISwipeGestureRecognizer *Swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    
    _rilegoule.contentView.userInteractionEnabled = YES;
    
    Swipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    [_rilegoule.contentView addGestureRecognizer:Swipe];
    
    //添加点击播放手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_rilegoule.scrollView addGestureRecognizer:tap];
    
    [_rilegoule aminmationShow];
}

#pragma mark - 平移手势触发事件
- (void)panAction:(UISwipeGestureRecognizer *)swipe {
    
    // 关闭播放器
    if (self.videoController) [self.videoController dismiss];
    
    // 重新显示tabBar
    [UIView animateWithDuration:0.3f animations:^{
        
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 0);
    }];

    [_rilegoule animationDismissUsingCompeteBlock:^{
        
        _rilegoule = nil;
    }];
}

#pragma mark - 点击手势触发事件:播放视频
- (void)tapAction {
    
    // 1.弹出蒙版,占据整个屏幕
    [LZFCover show];
    
    EveryDayModel *model = [_array objectAtIndex:self.currentIndexPath.row];
    self.videoController.contentURL =[NSURL URLWithString:model.playUrl];
    
    // 显示播放器并全屏播放视频
    [self.videoController showInWindow];
}

//    AVPlayerViewController *play = [[AVPlayerViewController alloc] init];
//    play.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:model.playUrl]];
//    [play.player play];
//
//    [self presentViewController:play animated:YES completion:nil];

@end
