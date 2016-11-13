//
//  LZFVVViewController.m
//  DuoVedio
//
//  Created by 刘志锋 on 16/10/15.
//  Copyright © 2016年 longroader. All rights reserved.
//

#import "LZFVVViewController.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LZFVVideoItem.h"
#import "LZFRefreshHeader.h"
#import "LZFRefreshFooter.h"
#import "KRVideoPlayerController.h"
#import "LZFVVVedioCell.h"
#import "LZFDetailViewController.h"

@interface LZFVVViewController ()

/** 所有视频数据 */
@property (nonatomic, strong) NSArray<LZFVVideoItem *> *videosArr;

@end

@implementation LZFVVViewController

static NSString * const videoCellID = @"videoCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTable];
    
    [self loadNewVideos];
    
    [self setupRefresh];
}

#pragma mark - 基本设置
- (void)setupTable {
    
    self.navigationItem.title = @"感悟人生·微电影";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 250;
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LZFVVVedioCell class]) bundle:nil] forCellReuseIdentifier:videoCellID];
}

#pragma mark - 刷新
- (void)setupRefresh {
    
    // 1.创建下拉刷新
    self.tableView.mj_header = [LZFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewVideos)];
    
    // 2.默认下拉刷新一次
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 加载视频数据
- (void)loadNewVideos {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:@"http://app.vmoiver.com/apiv3/post/getPostByTab" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // LZFWriteToPlist(responseObject, @"vedio");
        
        // 1.字典数组 -> 模型数组
        self.videosArr = [LZFVVideoItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 2.刷新数据
        [self.tableView reloadData];
        
        // 让【刷新控件】结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        LZFLog(@"%@", error);
        
        // 让【刷新控件】结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.videosArr.count;
}

#pragma mark - Table view 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZFVVVedioCell *cell = [LZFVVVedioCell cellWithTableView:tableView];
    
    // 给cell设置数据
    cell.videoItem = self.videosArr[indexPath.row];
    
     // 未自定义cell之前设置cell基本数据，查看是否拿到网络数据
//    LZFVVideoItem *videoItem = self.videosArr[indexPath.row];
//    cell.textLabel.text = videoItem.title;
//    cell.detailTextLabel.text = videoItem.rating;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:videoItem.image] placeholderImage:[UIImage imageNamed:@"Video_Bg"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建视频详情页控制器
    LZFDetailViewController *detailVc = [[LZFDetailViewController alloc] init];
    
    UIWebView *detailWebView = [[UIWebView alloc] init];
    detailWebView.backgroundColor = [UIColor whiteColor];
    detailWebView.scrollView.bounces = NO;
    
    CGFloat playerHeight = LZFScreenWidth * (9.0 / 16.0);
    detailWebView.frame = CGRectMake(0, playerHeight, LZFScreenWidth, LZFScreenHeight - playerHeight + 10);
    
    LZFVVideoItem *videoItem = self.videosArr[indexPath.row];
    NSURL *url = [NSURL URLWithString:videoItem.request_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [detailWebView loadRequest:request];
    
    [detailVc.view addSubview:detailWebView];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - 动态隐藏导航条
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if(velocity.y > 0) { // 加速度 > 0 时隐藏导航条
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

@end
