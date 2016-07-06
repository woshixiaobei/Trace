//
//  CRANewsVideoViewController.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsVideoViewController.h"
#import "CRANewsVideoLayout.h"
#import "CRANewsVideoCell.h"
#import "CRANewsVideoModel.h"
#import <MediaPlayer/MediaPlayer.h>


static NSString *videoID = @"videoID";

@interface CRANewsVideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

// collectionView
@property (nonatomic, weak) UICollectionView *collectionView;
//视频控制器的数据
@property (nonatomic, strong) NSArray *newsVideoModels;
@end

@implementation CRANewsVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
    
    // http://c.3g.163.com/nc/video/Tlist/T1457069346235/0-10.html
    [self loadVideoData];
}

- (void)loadVideoData {
    NSString *urlString = @"http://c.3g.163.com/nc/video/Tlist/T1457069346235/0-10.html";
    NSString *channel = @"T1457069346235";
    
    [CRANewsVideoModel newsWithVideoURLString:urlString channel:channel completationHandle:^(NSArray *array) {
       
        self.newsVideoModels = array;
        
        // 重新刷新数据
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRANewsVideoModel *model = _newsVideoModels[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.mp4_url];
    
    MPMoviePlayerViewController *MVPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [MVPlayer.moviePlayer prepareToPlay];
    [self presentMoviePlayerViewControllerAnimated:MVPlayer];
    
    [MVPlayer.view setBackgroundColor:[UIColor clearColor]];
    [MVPlayer.view setFrame:self.view.bounds];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackWhenFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:MVPlayer.moviePlayer];

}

- (void)callBackWhenFinished:(NSNotification *)n {
    
    NSLog(@"%@",[n object]);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:[n object]];
    
    [self dismissMoviePlayerViewControllerAnimated];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _newsVideoModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CRANewsVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:videoID forIndexPath:indexPath];

    CRANewsVideoModel *model = _newsVideoModels[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CRANewsVideoLayout *layout = [[CRANewsVideoLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    

    [collectionView registerNib:[UINib nibWithNibName:@"CRANewsVideoCell" bundle:nil] forCellWithReuseIdentifier:videoID];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
   // 记录
    _collectionView = collectionView;
}

@end
