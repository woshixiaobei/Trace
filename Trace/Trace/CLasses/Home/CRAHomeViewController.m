//
//  CRAHomeViewController.m
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeViewController.h"
#import "CRASliderView.h"
#import "CRAHomeTotalModel.h"
#import "CRAHomeGuessCell.h"
#import "CRAHomeFamousTableViewCell.h"
#import "CRAHomeButtonsTableViewCell.h"

/**
 *  通知
 */
// 点击按钮
extern NSString *const CRAHomeButtonsCellCollectionSelected;
// 点击推荐
extern NSString *const CRAHomeFamousCellCollectionSelected;

/**
 *  可重用标识符
 */
static NSString *cellId = @"cellId";
static NSString *CRAHomeFamousTableViewCellId = @"CRAHomeFamousTableViewCellId";
static NSString *CRAHomeButtonsTableViewCellId = @"CRAHomeButtonsTableViewCellId";

@interface CRAHomeViewController () <UITableViewDelegate,UITableViewDataSource>

/**
 *  轮播器视图
 */
@property (nonatomic,strong) CRASliderView *sliderView;


@end

@implementation CRAHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置界面
    //self.tabBarController.selectedIndex = 0;
    [self setupUI];
    
    // 加载网络数据
    [self loadNetData];
    
    // 刷新动画
    [self refreshNetData];
    
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToCircle:) name:CRAHomeButtonsCellCollectionSelected object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToBusinessDetail:) name:CRAHomeFamousCellCollectionSelected object:nil];
}



#pragma mark - 实现通知方法
/**
 *  跳转到商家界面
 */
- (void)pushToCircle:(NSNotification *)notification {
    
    Class cls = NSClassFromString(@"CRAInformationViewController");
    
    [self.navigationController pushViewController:[cls new] animated:YES];
    
}

/**
 *  跳转到商家详情界面
 */
- (void)pushToBusinessDetail:(NSNotification *)notification {
    
    Class cls = NSClassFromString(@"CRAMyOrdersViewController");
    
    [self.navigationController pushViewController:[cls new] animated:YES];
}

/**
 *  注销通知
 */
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - tableView 的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        if (_guessList != nil) {
            return _guessList.count;
        }
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        tableView.rowHeight = 177;
        
        CRAHomeButtonsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CRAHomeButtonsTableViewCellId forIndexPath:indexPath];
        if (_circleList != nil) {
            
            cell.circleModelList = _circleList;
        }
        
        return cell;
        
    }
    
    if (indexPath.section == 1 || indexPath.section == 3) {
        
        tableView.rowHeight = 33;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *text = indexPath.section == 1 ? @"名家推荐" : @"猜你喜欢";
        cell.textLabel.text = text;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.textLabel.textColor = indexPath.section == 1 ? [UIColor cz_colorWithHex:0xF16264] : [UIColor cz_colorWithHex:0xF070AB];
        
        return cell;
        
    }
    
    if (indexPath.section == 2) {
        tableView.rowHeight = 177;
        CRAHomeFamousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CRAHomeFamousTableViewCellId forIndexPath:indexPath];
        
        if (_famousList != nil) {
            cell.famousModelList = _famousList;
        }
        
        return cell;
    }
    
    
    tableView.rowHeight = 100;
    
    CRAHomeGuessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGuessCellId" forIndexPath:indexPath];
    
    if (_guessList != nil) {
        cell.model = _guessList[indexPath.row % 4];
    }
    cell.opaque = YES;
    
    return cell;
    
    
}

#pragma mark - tableView 的代理方法
// 组头间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == 2 || section == 4) {
        return 0.1;
    }
    
    return 6;
}
// 组尾间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class cls = NSClassFromString(@"CRABusinessViewController");
    
    [self.navigationController pushViewController:[cls new] animated:YES];
}

#pragma mark - 加载数据
// 判断是否有沙盒缓存
- (void)loadNetData {
    
    NSString *cachePath = [@"HomeData.plist" cz_appendCacheDir];
    
    NSDictionary *modelDict = [NSDictionary dictionaryWithContentsOfFile:cachePath];
    
    if (modelDict != nil) {
        
        [self loadDataForNetWithCachePath:nil Data:modelDict];
        
        return;
    }
    
    CRANetworkManager *manager = [CRANetworkManager sharedManager];
    [manager dataListWithType:@"homeData" parameters:@{@"anu": @"api/1/index/get_index_info"} completion:^(NSDictionary *data, NSError *error) {
        
        if (data == nil) {
            
            return ;
        }
        
        [self loadDataForNetWithCachePath:cachePath Data:data];
    }];
    
}

- (void)loadDataForNetWithCachePath:(NSString *)cachePath Data:(NSDictionary *)data{
    
    // 首页圈子 数据
    NSArray <CRAHomeTotalModel *> *circleArray = [NSArray yy_modelArrayWithClass:[CRAHomeTotalModel class] json:data[@"group"][@"list"]];
    _circleList = circleArray;
    
    // 猜你喜欢 数据
    NSArray <CRAHomeTotalModel *> *guessArray = [NSArray yy_modelArrayWithClass:[CRAHomeTotalModel class] json:data[@"guess"][@"list"]];
    _guessList = guessArray;
    
    // 名家推荐 数据
    NSArray <CRAHomeTotalModel *> *famousArray = [NSArray yy_modelArrayWithClass:[CRAHomeTotalModel class] json:data[@"famous"][@"list"]];
    _famousList = famousArray;
    
    // 轮播器 数据
    NSArray <CRAHomeTotalModel *> *focusArray = [NSArray yy_modelArrayWithClass:[CRAHomeTotalModel class] json:data[@"focus"][@"list"]];
    
    _sliderView.focus = focusArray;
    
    // 写入缓存
    [data writeToFile:cachePath atomically:YES];
    
    // 重新加载数据
    [self.tableView reloadData];
}

/**
 *  刷新数据
 */
- (void)refreshNetData {
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNetData)];
    
    // 上拉刷新
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadNetData)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    [footer setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    [footer setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    [header setTitle:@"暂无更多哦-。-" forState:MJRefreshStateIdle];
    [header setTitle:@"松手即可刷新哟 ~" forState:MJRefreshStatePulling];
    [header setTitle:@"卖命加载中 ..." forState:MJRefreshStateRefreshing];
    
    [footer setTitle:@"暂无更多哦-。-" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手即可刷新哟 ~" forState:MJRefreshStatePulling];
    [footer setTitle:@"卖命加载中 ..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    footer.stateLabel.textColor = [UIColor redColor];
    
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}

/**
 *  重新加载数据
 */
- (void)reloadNetData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
    });
}

#pragma mark - 设置界面
- (void)setupUI {
    
    // 底部视图
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    [self.view addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 顶部轮播器
    CGRect sliderRect = CGRectMake(0, 0, MainScreenWidth, 212.5);
    CRASliderView *sliderView = [[CRASliderView alloc] initWithFrame:sliderRect];
    
    // 设置顶部视图
    tv.tableHeaderView = sliderView;
    tv.tableHeaderView.frame = sliderView.frame;
    
    // 设置代理和数据源
    tv.delegate = self;
    tv.dataSource = self;
    
    // 注册可重用标识符
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    [tv registerClass:[CRAHomeButtonsTableViewCell class] forCellReuseIdentifier:CRAHomeButtonsTableViewCellId];
    
    [tv registerNib:[UINib nibWithNibName:@"CRAHomeGroupButtonsCell" bundle:nil] forCellReuseIdentifier:@"HomeGroupCellId"];
    
    [tv registerClass:[CRAHomeFamousTableViewCell class] forCellReuseIdentifier:CRAHomeFamousTableViewCellId];
    
    [tv registerNib:[UINib nibWithNibName:@"CRAHomeGuessCell" bundle:nil] forCellReuseIdentifier:@"HomeGuessCellId"];
    
    // 设置属性
    tv.showsVerticalScrollIndicator = NO;
    tv.showsHorizontalScrollIndicator = NO;
    
    // 记录属性
    _sliderView = sliderView;
    _tableView = tv;
    
}
@end
