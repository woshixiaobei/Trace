//
//  CRANewsViewController.m
//  Trace
//
//  Created by Arvin on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRANewsViewController.h"
#import "CRANewsKeyCell.h"
#import "CZAdditions.h"
#import "CRASliderView.h"
#import "CRANewsCategoryView.h"
#import "CRANewsISayViewController.h"
#import "CRANewsKeyModel.h"
#import "CRANewsDetailViewController.h"
#import "CRAHomeTotalModel.h"

static NSString *cellId = @"cellId";

@interface CRANewsViewController ()<UITableViewDataSource,UITableViewDelegate>
// 首页轮播器视图
@property (nonatomic, weak)  CRASliderView *slideView;
// 首页分类视图
@property (nonatomic, weak) UIView *categoryView;
// 首页底部tableView
@property (nonatomic, weak) UITableView *bottomTableView;

// 首页新闻数据
@property (nonatomic, strong) NSMutableArray *newsKeyModels;


@end

@implementation CRANewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    // 给轮播器视图传输图片数据
    _slideView.focus = [self loadNewsSlideImage];
    
    // 加载底部的滚动的新闻的数据
    [self loadNewsKeyModelData];

    // 刷新控件
    [self refreshNetData];
    
}

#pragma mark - 设置下拉刷新控件
/**
 *  刷新数据
 */
- (void)refreshNetData {
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadNetData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    [header setTitle:@"暂无更多哦-。-" forState:MJRefreshStateIdle];
    [header setTitle:@"松手即可刷新哟 ~" forState:MJRefreshStatePulling];
    [header setTitle:@"卖命加载中 ..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    _bottomTableView.mj_header = header;
}

/**
 *  重新加载数据
 */
- (void)refreshLoadNetData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_bottomTableView.mj_header endRefreshing];
        
    });
}


#pragma mark - 给首页底部新闻加载数据
- (void)loadNewsKeyModelData {
   
    //1. 增加提示
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"努力加载中... 🐶🐶🐶";
    [HUD show:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD hide:NO];
        [HUD removeFromSuperview];
    });
    
    NSString *urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348649079062/%zd-20.html",self.newsKeyModels.count];
    
    [CRANewsKeyModel newsWithURLString:urlString completionHandle:^(NSArray *arrayModels) {
       
        if (self.newsKeyModels.count == 0 ) {
            self.newsKeyModels = arrayModels.mutableCopy;
        } else {
//            [self.newsKeyModels addObjectsFromArray:arrayModels];
            self.newsKeyModels = [self.newsKeyModels arrayByAddingObjectsFromArray:arrayModels].mutableCopy;
        }
        
        // 刷新表格数据
        [self.bottomTableView reloadData];
    }];
    
}


#pragma mark - 无线刷新
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==  ([tableView numberOfRowsInSection:0] - 1)) {
        
        // 判断最后一行出现的时候，刷新数据
        [self loadNewsKeyModelData];
        
    }
    
}



#pragma mark - 加载轮播器视图的广告
- (NSArray *)loadNewsSlideImage {
    
    NSDictionary *dict1 = @{@"cover":@"http://iosapi.itcast.cn/life/images/middle_20151118132120000000_1_308026_88.jpg",@"title":@"今年来170多项目落户青岛蓝谷"};
    NSDictionary *dict2 = @{@"cover":@"http://iosapi.itcast.cn/life/images/middle_20151117135509000000_1_128119_100.jpg",@"title":@"今冬怎样保持空气清新？"};
    NSDictionary *dict3 = @{@"cover":@"http://iosapi.itcast.cn/life/images/middle_20151117133539000000_1_265046_50.jpg",@"title":@"\"公交即将\"接轨\"地铁\""};
    NSArray *slideArray = @[dict1,dict2,dict3];
                            
    // 遍历数组，字典转模型
    NSArray *slideModels = [NSArray yy_modelArrayWithClass:[CRAHomeTotalModel class] json:slideArray];
    return slideModels;
}
#pragma mark - 选中的新闻分类
- (void)categoryViewSeletedIndex:(CRANewsCategoryView *)categoryView {
    NSLog(@"%zd",categoryView.selectedIndex);
    
    NSArray <NSString *> *titles = @[@"实时新闻",@"图片新闻",@"视频新闻",@"我要爆料"];
    NSArray *categoryNews = @[@"CRANewsTimeViewController",@"CRANewsPictureViewController",@"CRANewsVideoViewController",@"CRANewsISayViewController"];
    
    NSInteger selectedIndex = categoryView.selectedIndex;
    Class cls = NSClassFromString(categoryNews[selectedIndex]);
    
    NSAssert([cls isSubclassOfClass:[UIViewController class]], @"类名不正确！！！");

    UIViewController *vc = [cls new];
    vc.title = titles[selectedIndex];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转控制器，并且传递数据
    CRANewsDetailViewController *detailVC = [[CRANewsDetailViewController alloc] init];
    detailVC.title = @"新闻详情";
    // 1. 取出顶部的新闻详情数据
    detailVC.topModel = _newsKeyModels[indexPath.row];
    // 2.取出底部的相关新闻数据（随机）
    NSInteger number = arc4random_uniform((u_int32_t)_newsKeyModels.count - 4);
    detailVC.bottomModels = [_newsKeyModels subarrayWithRange:NSMakeRange(number, 4)].mutableCopy;
    // 3. 跳转
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsKeyModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CRANewsKeyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    CRANewsKeyModel *model = _newsKeyModels[indexPath.row];
    cell.newsKeyModel = model;
    
    return cell;
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    
    [self.view addSubview:tableView];
    
    tableView.estimatedRowHeight = 130;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    tableView.dataSource = self;
    tableView.delegate = self;

    [tableView registerNib:[UINib nibWithNibName:@"CRANewsKeyCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(- 49);
    }];
    
  
    // 添加 tabelView 的顶部视图
    UIView *headerView = [self setUpTableViewHeaderView];
    tableView.tableHeaderView = headerView;
    
    // 记录
    _bottomTableView = tableView;
}

/**
 *  添加 tabelView 顶部视图
 *  顶部视图包括 ‘轮播器视图’和‘新闻分类视图’
 */
- (UIView *)setUpTableViewHeaderView {
    
    CGFloat height = 326;
    CGFloat width = self.view.bounds.size.width;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    //1.添加轮播视图
    CRASliderView *slideView = [[CRASliderView alloc] initWithFrame:CGRectMake(0, 0, width, 230)];
    
    [bottomView addSubview:slideView];
    
    //2.新闻分类模块
    CRANewsCategoryView *categoryView = [[CRANewsCategoryView alloc] initWithFrame:CGRectMake(0, 230, width, 96)];
    
    [bottomView addSubview:categoryView];
    
    [categoryView addTarget:self action:@selector(categoryViewSeletedIndex:) forControlEvents:UIControlEventValueChanged];
    
    // 记录
    _categoryView = categoryView;
    _slideView = slideView;
    
    
    return bottomView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
