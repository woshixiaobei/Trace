//
//  CRADetailViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRADetailViewController.h"
#import "CRAHeaderView.h"
#import "CRABusinessViewController.h"
#import "CRAInformationViewController.h"
#import "CRACommentViewController.h"

#define KheaderHeight 30

extern NSString *const CRABusinessAreaListSelectedNotification;
extern NSString *const CRABusinessAreaListDeselectedNotification;

NSString *cellId = @"cellId";
@interface CRADetailViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

//顶部视图
@property (nonatomic, weak) CRAHeaderView *headView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPanGestureRecognizer *panGesture;
@end

@implementation CRADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedList:) name:CRABusinessAreaListSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselectedList:) name:CRABusinessAreaListDeselectedNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark- 实现通知中心的监听方法
- (void)selectedList:(NSNotification *)n {
    _panGesture.enabled = NO;
    _scrollView.scrollEnabled = NO;
    
}

- (void)deselectedList:(NSNotification *)n {
    _scrollView.scrollEnabled = YES;
    _panGesture.enabled = YES;

}
#pragma mark- 实现拖拽手势的监听方法
- (void) panGesture:(UIPanGestureRecognizer *)recognizer {

    //1.获取手势移动的距离
    CGPoint translation = [recognizer translationInView:self.view];
    if (ABS((translation.x) > (translation.y))) {
        return;
    }
}

#pragma mark-UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark-实现头部视图的监听方法
- (void)changeChannel:(CRAHeaderView *)headerView {
    NSInteger index = headerView.selectIndex;
    
    //根据indexPath 来选中索引
    CGFloat offsetX = index *self.view.bounds.size.width;
    
    //滚动到相应的row中
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];

}
#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%zd %zd %zd",scrollView.isDragging,scrollView.isTracking,scrollView.decelerating);
    //判断是否是手指拖动
    if (scrollView.isDragging ||scrollView.isTracking||scrollView.isDecelerating) {
        _headView.offsetX = scrollView.contentOffset.x / 3;
        
    }
}

#pragma mark-搭建界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    //1.设置顶部视图
    CRAHeaderView *headerView = [[CRAHeaderView alloc]init];
    headerView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0];
    [self.view addSubview:headerView];
    
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(KheaderHeight);
    }];
    
    //对于自定义控件添加监听事件
    [headerView addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventValueChanged];
    
    //2.设置底部的内容视图(UIScrollView)
    UIScrollView *vContent = [self setupContent];
    [self.view addSubview:vContent];
    [vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
   //3.添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    
    //记录成员变量
    _headView = headerView;
    _scrollView = vContent;
    _panGesture = pan;
    
}

#pragma mark-设置底部视图的内容控制器
- (UIScrollView *)setupContent {

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    //0.设置scrollView代理
    scrollView.delegate = self;
    //1.设置一个内容视图,后续的视图,添加这个尺寸视图
    UIView *vSize = [[UIView alloc]init];
    [scrollView addSubview:vSize];
    
    //自动布局
    [vSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView).multipliedBy(3);
        make.height.equalTo(scrollView);
    }];
    
    //2.添加多个子控制器
    NSArray *vcNames = @[@"CRAInformationViewController",@"CRABusinessViewController",@"CRACommentViewController"];
    //遍历数组
    NSMutableArray <UIViewController *>*arrayM = [NSMutableArray array];
    for (NSString *title in vcNames) {
        Class cls = NSClassFromString(title);
        UIViewController *vc = [[cls alloc]init];
        NSAssert([vc isKindOfClass:[UIViewController class]], @"%@不能转换成控制器",title);
        
        //添加子控制器
        [self cz_addChildController:vc intoView:vSize];
        [arrayM addObject:vc];
    }
        //自动布局
        [arrayM[0].view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(vSize);
            make.width.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        [arrayM[1].view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vSize);
            make.size.mas_equalTo(scrollView);
            make.left.equalTo(arrayM[0].view.mas_right);
        }];
        [arrayM[2].view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vSize);
            make.size.equalTo(scrollView);
            make.left.equalTo(arrayM[1].view.mas_right);
        }];
    
    
    return scrollView;
}
@end
