//
//  CRANewsTimeViewController.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsTimeViewController.h"
#import "CRANewsTimeModel.h"
#import "CRANewsTimeCell.h"
#import "CRANewsDetailViewController.h"

static NSString *bigCell = @"bigCell";
static NSString *smallCell = @"smallCell";

@interface CRANewsTimeViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据模型数组
 */
@property (nonatomic, strong) NSMutableArray *newsTimeModels;
/**
 *   备用数据模型数组
 */
@property (nonatomic, strong) NSMutableArray *newsStoreModels;

/**
 *  tabelView
 */
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation CRANewsTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    // 加载数据
    _newsTimeModels = [NSMutableArray array];
    _newsStoreModels = [NSMutableArray array];
    [self loadDataWithURLString:_urlString];
    
    
}
#pragma mark - 加载数据
- (void)loadDataWithURLString:(NSString *)urlString {
    
    
    if ( !urlString) {
        urlString = @"http://c.3g.163.com/nc/article/list/T1348649580692/0-20.html";
    }
    
    [CRANewsTimeModel newsWithTimeURLString:urlString channel:nil completionHandle:^(NSArray *array) {
        
        //1. 排序 过去的时间早，就是数值小 但是要排在数组后面，所以要‘降序’排序
        array = [array sortedArrayUsingComparator:^NSComparisonResult(CRANewsTimeModel *obj1, CRANewsTimeModel *obj2) {
            return [obj2.ptime compare:obj1.ptime];
        }];
        
//        NSMutableArray *arrayM = [NSMutableArray array];
//        NSMutableArray *storeM = [NSMutableArray array];
        //2. 遍历数组，把后面8个数据保存到  备用数组中
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if (idx >= array.count - 12) {
                [self.newsStoreModels addObject:obj];
            } else {
                [self.newsTimeModels addObject:obj];
            }
            
        }];
        
//        self.newsTimeModels = arrayM;
//        self.newsStoreModels = storeM;
        
        //3. 刷新数据, 注意要在 block 内部刷新数据
        [self.tableView reloadData];
        
    }];
 
//     [self.tableView reloadData]; ***** 写在这里是错的
}


/**
 *  根据将要减速的时候监听的方法调用是否刷新数据和滚动
 */
- (void)tipAndScrollToSection:(NSInteger)section {
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    // 设置文字
    HUD.labelText = @"正在努力加载中...🐶🐶🐶";
    // 加入视图
    [self.navigationController.view addSubview:HUD];
    // 动态展示
    [HUD show:YES];
    
    // 加一个延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (section <= 4) {
            // 隐藏 不带动画
            [HUD hide:NO];
            // 在变成 hidden 时移除
            [HUD removeFromSuperview];
            
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        } else {
            // 设置提示文字
            HUD.labelText = @"今天没有数据了..";
            // 改变样式
            HUD.mode = MBProgressHUDModeText;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 变成 hidden 时删除
                [HUD removeFromSuperview];
            });
        }
    });
}

#pragma mark - UITableViewDelegate

// 根据表格的尾视图判断加载数据
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"滚动的距离 = %lf, 表格视图的位子原点的 y值 = %lf",scrollView.contentOffset.y, self.tableView.tableFooterView.frame.origin.y);
    
    if (scrollView.contentOffset.y + self.tableView.bounds.size.height > self.tableView.tableFooterView.frame.origin.y + 50) {
        
        NSArray *subArr;
        switch (_newsTimeModels.count) {
            case 8:
                subArr = [self.newsStoreModels subarrayWithRange:NSMakeRange(0, 4)];
                _newsTimeModels = [_newsTimeModels arrayByAddingObjectsFromArray:subArr].mutableCopy;
                [self tipAndScrollToSection:2];
                break;
                
            case 12:
                subArr = [self.newsStoreModels subarrayWithRange:NSMakeRange(4, 4)];
                _newsTimeModels = [_newsTimeModels arrayByAddingObjectsFromArray:subArr].mutableCopy;
                [self tipAndScrollToSection:3];
                break;
                
            case 16:
                subArr = [_newsStoreModels subarrayWithRange:NSMakeRange(8, 4)];
                _newsTimeModels = [_newsTimeModels arrayByAddingObjectsFromArray:subArr].mutableCopy;
                [self tipAndScrollToSection:4];
                break;
                
            case 20:
                [self tipAndScrollToSection:5];
                break;
                
            default:
                break;
        }
    }
}

/**
 *  跳转控制器
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1. 随机准备底部视图数据
    NSMutableArray *bottomArrayM = [NSMutableArray array];
    NSInteger start = arc4random_uniform((u_int32_t)_newsStoreModels.count - 4);
    bottomArrayM = [_newsStoreModels subarrayWithRange:NSMakeRange(start, 4)].mutableCopy;
    // 2. 顶部视图 数据
//    分组的组数据
    NSMutableArray *arrayM = [_newsTimeModels subarrayWithRange:NSMakeRange(indexPath.section * 4, 4)].mutableCopy;
    CRANewsTimeModel *model = arrayM[indexPath.row];

    // 3. 跳转并且传递数据
    CRANewsDetailViewController *detailVC = [[CRANewsDetailViewController alloc] init];
    detailVC.topModel = model;
    detailVC.bottomModels = bottomArrayM.copy;
    detailVC.title = @"新闻详情";
    detailVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:detailVC animated:YES];
}


//- (void)loadDataWithURLString:(NSString *)urlString {
//    
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    HUD.labelText = @"使劲加载中";
//    [self.navigationController.view addSubview:HUD];
//    [HUD show:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [HUD hide:NO];
//        [HUD removeFromSuperview];
//    });
//    
//    if (!urlString) {
//        urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348649580692/%zd-20.html",_newsTimeModels.count];
//    }
//    [CRANewsTimeModel newsWithTimeURLString:urlString channel:nil completionHandle:^(NSArray *array) {
//        // 遍历排序，时间早的在要排在数组后面，所以要降序
//        array = [array sortedArrayUsingComparator:^NSComparisonResult(CRANewsTimeModel *obj1, CRANewsTimeModel *obj2) {
//            return [obj2.ptime compare:obj1.ptime];
//        }];
//        
//        //这里不用遍历了, 直接添加到数组
//        if (self.newsTimeModels.count == 0) {
//            self.newsTimeModels = array.mutableCopy;
//        } else {
//            [self.newsTimeModels addObjectsFromArray:array];
//        }
//        
//        
//        // 刷新表格
//        [self.tableView reloadData];
//    }];
//}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    //1. 每组的数据取出来之后，再取出来这一组中的对应行的数据
//    NSMutableArray *section = [NSMutableArray array];
//    section = [_newsTimeModels subarrayWithRange:NSMakeRange(indexPath.section * 4, 4)].mutableCopy;
//    CRANewsTimeModel *model = section[indexPath.row];
//    
//    //2. 设置详情界面的底部视图数据
//    _newsStoreModels = _newsTimeModels;
//    [_newsStoreModels removeObjectsInArray:section];
//    // 从存储的数据中，随机取出四条
//    NSInteger start = arc4random_uniform((u_int32_t)_newsStoreModels.count - 4);
//    NSMutableArray *bottomArray = [_newsStoreModels subarrayWithRange:NSMakeRange(start, 4)].mutableCopy;
//    
//    // 3. 跳转并且传递数据
//    CRANewsDetailViewController *detailVC = [[CRANewsDetailViewController alloc] init];
//    detailVC.topModel = model;
//    detailVC.bottomModels = bottomArray.copy;
//    detailVC.title = @"新闻详情";
//    detailVC.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:detailVC animated:YES];
//
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

// 返回组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray <CRANewsTimeModel *>*subArray = [_newsTimeModels subarrayWithRange:NSMakeRange(section * 4, 4)];
    
    UILabel *label = [UILabel cz_labelWithText:subArray[0].ptime fontSize:14 color:[UIColor blackColor]];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _newsTimeModels.count / 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellID = indexPath.row == 0 ? bigCell : smallCell;
   
    CRANewsTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // 设置模型数组，每组四个模型属性
    NSArray *subArray = [_newsTimeModels subarrayWithRange:NSMakeRange(indexPath.section * 4, 4)];
    
    cell.model = subArray[indexPath.row];
    
//    NSLog(@"%zd -- %zd",indexPath.section,indexPath.row);
    
    return cell;
}

#pragma mark - 设置界面
- (void)setupUI {
 
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableView];
    
    tableView.estimatedRowHeight = 150;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];



    [tableView registerNib:[UINib nibWithNibName:@"CRANewsTimeBig" bundle:nil] forCellReuseIdentifier:bigCell];
    [tableView registerNib:[UINib nibWithNibName:@"CRANewsTimeSmall" bundle:nil] forCellReuseIdentifier:smallCell];
    
    
    tableView.dataSource = self;
    tableView.delegate = self;

    // 加上一个表格尾视图 用于判断
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    
    //记录
    _tableView = tableView;
}


@end
