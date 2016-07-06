//
//  CRAMyOrdersViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAMyOrdersViewController.h"
#import "CRAmyOrdersHeaderView.h"

@interface CRAMyOrdersViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) CRAmyOrdersHeaderView *headerView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIPanGestureRecognizer *panGesture;
@end

@implementation CRAMyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)changeChannel:(CRAmyOrdersHeaderView *)headerView {
    NSInteger index = headerView.orderedSelectedIndex;
    
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
        _headerView.orderedOffsetX = scrollView.contentOffset.x / 2;
        
    }
}

#pragma mark-搭建界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    //1.设置顶部视图
    CRAmyOrdersHeaderView *headerView = [[CRAmyOrdersHeaderView alloc]init];
    headerView.backgroundColor = [UIColor colorWithWhite:0.88 alpha:1];
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
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
    _headerView = headerView;
    _scrollView = vContent;
    _panGesture = pan;
    
}

#pragma mark-设置底部视图的内容控制器
- (UIScrollView *)setupContent {
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    UIView *vSize = [[UIView alloc]init];
    [scrollView addSubview:vSize];
    
    [vSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView).multipliedBy(2);
        make.height.equalTo(scrollView);
    }];
    
    //添加多个子控制器
    NSArray *vcNames = @[@"CRANonPayViewController",@"CRAPayViewController"];

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
    
    return scrollView;
}

@end
