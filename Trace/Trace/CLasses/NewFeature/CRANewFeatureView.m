//
//  CRANewFeatureView.m
//  Trace
//
//  Created by 张玺科 on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRANewFeatureView.h"
#import "CRAMainTabBarController.h"


@interface CRANewFeatureView()<UIScrollViewDelegate>
/**
 * 滚动视图
 */
@property (nonatomic, weak) UIScrollView *scrollView;

/**
 * 分页控件
 */
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation CRANewFeatureView

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc{
//    NSLog(@"%s %d %s",__FUNCTION__,__LINE__,__FILE__);
}

#pragma mark - 设置数据
- (void)setImageNames:(NSArray *)imageNames {
    
    // 1. 用成员变量接收外部传递参数
    _imageNames = imageNames;
    // 2. 根据 imageNames 的个数，创建 imageView
    // 1> 准备一个 rect
    CGRect rect = self.bounds;
    // 2> 准备一个索引1
    NSInteger index = 0;
    for (NSString *name in imageNames) {
        
        // 1> 图像
        UIImage *image = [UIImage imageNamed:name];
        
        // 2> 图像视图
        // 会和图像一样大
        // 根据 index 计算 rect 的数值
        CGFloat offset = index * rect.size.width;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectOffset(rect, offset, 0)];
        
        // 设置图像
        iv.image = image;
        
        // 3> 添加到 scrollview
        [_scrollView addSubview:iv];
        // 4> 递增索引
        index++;
    }
    // 设置 contentSize
    CGFloat width = (imageNames.count + 1) * rect.size.width;
    _scrollView.contentSize = CGSizeMake(width, 0);
    // 创建更多按钮
    [self createMoreButton];
    
    // 设置分页控件属性
    // 1> 总页数
    _pageControl.numberOfPages = imageNames.count;
    // 2> 当前页数
    _pageControl.currentPage = 0;
}

- (void)createMoreButton{
    CGFloat marginRight = -20;
    CGFloat marginBottom = -80;
    CGSize btnSize = CGSizeMake(78, 40);
    for (UIView *v in _scrollView.subviews) {
        UIButton *btn = [[UIButton alloc]init];
        
        UIImage *image = [UIImage imageNamed:@"common_more_black"];
        [btn setImage:image forState:UIControlStateNormal];
        
        UIImage *imageH = [UIImage imageNamed:@"common_more_white"];
        [btn setImage:imageH forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        
        [v addSubview:btn];
        
        v.userInteractionEnabled = YES;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(v).offset(marginRight);
            make.bottom.equalTo(v).offset(marginBottom);
            make.size.mas_equalTo(btnSize);
        }];
        
        [btn addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickMoreButton:(UIButton *)btn{
    UIView *v = btn.superview;
    
    CGFloat scale = 2.0;
    [UIView animateWithDuration:1.0 animations:^{
        v.transform = CGAffineTransformMakeScale(scale, scale);
        v.alpha = 0;
        
       
        
//        [_delegate modal];
    } completion:^(BOOL finished) {
        
        //获取app
        UIApplication *app = [UIApplication sharedApplication];
        
        //创建控制器
        CRAMainTabBarController *tabbarVC = [[CRAMainTabBarController alloc]init];
        //设置根控制器
        app.keyWindow.rootViewController = tabbarVC;
        
        [self removeFromSuperview];
    }];
}

#pragma mark - UIScrollViewDelegate
/**
 * 只要滚动视图发生变化就会被调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"x -> %f", scrollView.contentOffset.x);
    
    // 使用 contentOffset.x / bounds.width
    CGFloat offsetX = scrollView.contentOffset.x;
    // 随着滚动变化而变化，输出是小数
    CGFloat page = offsetX / scrollView.bounds.size.width;
    
    // *** 设置页数，增加 0.5 然后取整，可以取到最接近的页数
    NSInteger pageNo = (NSInteger)(page + 0.5);
    
//    NSLog(@"page - %f - %zd", page, pageNo);
    
    // 设置页数
    _pageControl.currentPage = pageNo;
    
    // 判断页数，如果是最后一页，隐藏分页控件
    //    if (pageNo == _imageNames.count) {
    //        _pageControl.hidden = YES;
    //    } else {
    //        _pageControl.hidden = NO;
    //    }
    // 以上代码的简写！
    
    _pageControl.hidden = (pageNo == _imageNames.count);
}

/**
 * 滚动视图完全停止滚动会调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 可以根据 contentOffset 的 x 计算出所在页面数
    // 初始是0，每过一个页面，offset.x + scrollView 的宽度
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / scrollView.bounds.size.width;
    
//    NSLog(@"第 %zd 页", page);
    
    // 设置分页控件的页数
    _pageControl.currentPage = page;
    
    
    // 如果是最后一页，直接 removeFromSuperview
    if (page == _imageNames.count) {
        
        //获取app
        UIApplication *app = [UIApplication sharedApplication];
        
        //创建控制器
        CRAMainTabBarController *tabbarVC = [[CRAMainTabBarController alloc]init];
        //设置根控制器
        app.keyWindow.rootViewController = tabbarVC;
        
        // 直接从父视图删除
        [self removeFromSuperview];
    }
}

#pragma mark - 设置界面
- (void)setupUI{
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.bounds];
    
//    sv.backgroundColor = [UIColor blueColor];
    // 1.1 设置 scrollView 属性
    // 1> 分页
    sv.pagingEnabled = YES;
    // 2> 取消指示器 － 本质上是 imageView
    // 两个都取消之后，可以直接通过便利 scrollView 的 subviews 获得内部所有图像视图的内容
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    // 3> 禁用弹力属性
    sv.bounces = NO;
    
    sv.delegate = self;
    
    [self addSubview:sv];
    // 2. 记录属性
    _scrollView = sv;
    //代理
//    _scrollView.delegate = self;
    
    UIPageControl *pControl = [[UIPageControl alloc] init];
    
    pControl.numberOfPages = 8;
    pControl.currentPage = 3;
    
    pControl.pageIndicatorTintColor = [UIColor blackColor];
    
    pControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    
    pControl.userInteractionEnabled = NO;
    
    [self addSubview:pControl];
    
    CGFloat bottomMargin = -80;
    [pControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(bottomMargin);
        make.centerX.equalTo(self);
    }];
    
    _pageControl = pControl;
}


@end
