//
//  CRASliderView.h
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRASliderView.h"
#import "CRAHomeTotalModel.h"
#import "CRASliderCell.h"

#define KDataNum 1000

/**
 *  可重用cell标识符
 */
static NSString *celId = @"cellId";
/**
 自定义流布局
 */
@interface CRAFlowLayout : UICollectionViewFlowLayout

@end

@implementation CRAFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect rect = self.collectionView.bounds;
    
    self.itemSize = rect.size;
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

@end

@interface CRASliderView () <UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic, weak) UICollectionView *collectionView;
/**
 *  新闻标题
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 *  分页控件
 */
@property (nonatomic, weak) UIPageControl *newsPage;

@end

@implementation CRASliderView {
    
    // 滚动间隔
    NSTimeInterval _timeInteval;
    // 定时器
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.x / self.bounds.size.width;
    
    NSInteger pageNum = (NSInteger)(offset + 0.5);
    
    NSInteger index = pageNum % _focus.count;
    
    _newsPage.currentPage = index;
    
    _titleLabel.text = _focus[index].title;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat with = scrollView.bounds.size.width;
    
    NSInteger offset = (NSInteger)(scrollView.contentOffset.x / with);
    
    NSInteger items = [_collectionView numberOfItemsInSection:0];
    
    NSInteger index = _focus.count * KDataNum;
    
    if (offset == 0 || offset == items - 1) {
        if (offset == items - 1) {
            index = index - 1;
        }
        _collectionView.contentOffset = CGPointMake(with * index, 0);
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _timer.fireDate = [NSDate distantFuture];
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:_timeInteval];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _focus.count * KDataNum * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRASliderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celId forIndexPath:indexPath];
    
    NSUInteger index = indexPath.item % _focus.count;
    
    cell.urlString = _focus[index].cover;
    
    return cell;
}

#pragma mark - 设置数据

- (void)setFocus:(NSArray<CRAHomeTotalModel *> *)focus {
    
    _focus = focus;
    
    _newsPage.numberOfPages = focus.count;
    _titleLabel.text = focus[0].title;
    [self.collectionView reloadData];
    
    // 初始化开始位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:focus.count * KDataNum inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSTimeInterval interval = 2.0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(uptimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 记录成员变量
    _timeInteval = interval;
    _timer = timer;
}

#pragma mark - 时钟监听

- (void)uptimer {
    
    if (self.window == nil) {
        
        return;
    }
    
    NSIndexPath *indexPath = [_collectionView indexPathsForVisibleItems].lastObject;
    
    NSIndexPath *new = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:new atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 设置界面

- (void)setupUI {
    
    CGFloat barHight = 24;
    CGFloat pcMargin = 15;
    CGFloat titleMargin = 10;
    
    // 添加控件
    CRAFlowLayout *flowLayout = [[CRAFlowLayout alloc]init];
    
    
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
    
    
    
    cv.bounces = NO;
    cv.pagingEnabled = YES;
    cv.showsVerticalScrollIndicator = NO;
    cv.showsHorizontalScrollIndicator = NO;
    cv.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:cv];
    
    cv.dataSource = self;
    cv.delegate = self;
    [cv registerClass:[CRASliderCell class] forCellWithReuseIdentifier:celId];
    
    //    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self);
    //    }];
    
    UIView *bar = [UIView new];
    bar.backgroundColor = [UIColor blackColor];
    bar.alpha = 0.6;
    [self addSubview:bar];
    
    UIPageControl *pages = [[UIPageControl alloc]init];
    pages.numberOfPages = 1;
    pages.currentPageIndicatorTintColor = [UIColor whiteColor];
    pages.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 禁用交互
    pages.userInteractionEnabled = NO;
    
    [self insertSubview:pages aboveSubview:bar];
    
    
    UILabel *lTitle = [UILabel cz_labelWithText:@"一起来追寻生活的痕迹吧！" fontSize:12 color:[UIColor cz_colorWithHex:0xFFFFFF]];
    [bar addSubview:lTitle];
    
    // 自动布局
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self);
        make.height.mas_equalTo(barHight);
    }];
    [pages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(bar).mas_offset(-pcMargin);
        make.centerY.equalTo(bar);
    }];
    [lTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bar);
        make.leading.equalTo(bar).mas_offset(titleMargin);
        //make.trailing.equalTo(pc.mas_leading).mas_greaterThanOrEqualTo(pcMargin);
    }];
    
    // 记录控件
    _collectionView = cv;
    _newsPage = pages;
    _titleLabel = lTitle;
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    
    [_timer invalidate];
}


- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [_timer invalidate];
}
@end
