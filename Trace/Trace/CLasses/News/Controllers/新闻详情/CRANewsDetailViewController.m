//
//  CRANewsDetailViewController.m
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsDetailViewController.h"
#import "CRANewsDetailCell.h"
#import "CRANewsTimeModel.h"
#import "CRANewRemarkModel.h"
#import "CRANewsDetailHeaderView.h"
#import "CRANewsDetailFooterView.h"

// 监听的通知名
extern NSString *const kDidClickButtonShowMoreRemarkNotification;
extern NSString *const kDidClickButtonSaveRemarkAndShowRemarkNotification;


static NSString *cellId = @"cellId";

@interface CRANewsDetailViewController ()<UITableViewDataSource>

@property (nonatomic, weak) UITableView *remarkTableview;

/**
 *  评论数据数组
 */
@property (nonatomic, strong) NSMutableArray <CRANewRemarkModel *> *remarkModels;


@end

@implementation CRANewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
    
    // 注册通知，监听 ‘点击显示更多的按钮'
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowMoreRemark:) name:kDidClickButtonShowMoreRemarkNotification object:nil];
    // 注册通知，点击‘发表评价按钮’接收 监听 '用户输入信息'，并且显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveSaveNewRemarkAndShow:) name:kDidClickButtonSaveRemarkAndShowRemarkNotification object:nil];
}

#pragma mark - 通知监听方法
/**
 *  方法内实现保存用户输入的信息，并且显示在表格上面
 */
- (void)recieveSaveNewRemarkAndShow:(NSNotification *)n {
    
    // 1.取出用户的发送的对象
//    CRANewsDetailHeaderView *headerView = n.object;
    // 2.通过取出的对象 的属性，再取出字典
//    NSDictionary *dict =  headerView.remarkDcit;
    
    // 1. 上面的两步可以直接取出来
    NSDictionary *remarkDict = n.userInfo;
    // 2. 字典转模型
    CRANewRemarkModel *remarkModel = [CRANewRemarkModel remarkModelWithDict:remarkDict];
    // 3. 将模型保存到数组中
    [_remarkModels insertObject:remarkModel atIndex:0];
    // 4. 刷新表格
    [_remarkTableview reloadData];
    
}


/**
 *  在方法内部实现点击按钮增加更多的评论
 */
- (void)receiveShowMoreRemark:(NSNotification *)n {
    
    NSDictionary *dict = @{
                           @"userName" : @"X*****O",
                           @"userIcon" : @"newsImage01",
                           @"userRemark" : @"说天下大势，分久必合，合久必分。！！！。千秋功罪，谁人曾与评说？"
                          };
    // 字典转模型
    CRANewRemarkModel *remarkModel = [CRANewRemarkModel remarkModelWithDict:dict];
    // 评论数组保存新的模型，
    [_remarkModels addObject:remarkModel];
    //并且刷新表格显示出来
    [_remarkTableview reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.remarkModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CRANewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.model = self.remarkModels[indexPath.row];
    
    
    return cell;
}

#pragma mark - 设置界面
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 120;
    
    [self.view addSubview:tableView];
    
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [tableView registerNib:[UINib nibWithNibName:@"CRANewsDetailCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    tableView.dataSource = self;

    // 1.表格顶部视图
    CRANewsDetailHeaderView *header = [[NSBundle mainBundle] loadNibNamed:@"CRANewsDetailHeaderView" owner:nil options:nil].lastObject;
    // 相当于如下
//    CRANewsDetailHeaderView *header = [[UINib nibWithNibName:@"CRANewsDetailHeaderView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    tableView.tableHeaderView = header;
    // 传递数据
    header.model = self.topModel;
    
    // 2. 表格底部视图
    CRANewsDetailFooterView *footer = [[UINib nibWithNibName:@"CRANewsDetailFooterView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    tableView.tableFooterView = footer;
    // 传递数据
    footer.footerModels = self.bottomModels;
    

    // 记录
    _remarkTableview = tableView;
}



#pragma mark - 懒加载
/**
 *  加载评论信息
 */
- (NSMutableArray<CRANewRemarkModel *> *)remarkModels {
    if (_remarkModels == nil) {
        NSDictionary *dict1 = @{
                                @"userName" : @"X***XX",
                                @"userIcon" : @"newsImage01",
                                @"userRemark" : @"五公里耐力跑……跑出效果，跑出活力！！！！。"
                                };
        NSDictionary *dict2 = @{
                                @"userName" : @"Y***YY",
                                @"userIcon" : @"newsImage02",
                                @"userRemark" : @"拿下总冠军！感谢支持我的小伙伴们，，，，好开心！！！",
                                };
        NSDictionary *dict3 = @{
                                @"userName" : @"Z***ZZ",
                                @"userIcon" : @"newsImage03",
                                @"userRemark" : @"汉朝自春林斩白蛇而起义，一统天下，后来光武中兴，传至献帝，遂分为三国。",
                                };
        
        NSArray *dictArr = @[dict1,dict2,dict3];
        
//        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArr.count];
        NSMutableArray *arrayM = [NSMutableArray array];
        
        [dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CRANewRemarkModel *model = [CRANewRemarkModel remarkModelWithDict:obj];
            [arrayM addObject:model];
        }];
        
        _remarkModels = arrayM;
    }
    return _remarkModels;
}
@end










