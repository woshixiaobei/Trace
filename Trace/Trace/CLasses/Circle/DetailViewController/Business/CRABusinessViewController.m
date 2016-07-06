//
//  CRABusinessViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRABusinessViewController.h"
#import "CRABusinessHeaderView.h"
//#import "CRABusinjessCell.h"
#import "CRABussinessCell.h"
#import "CRABusinessViewController.h"
#import "CRACitiesModel.h"
#import "CRANetworkManager.h"
#import "CRAHomeTotalModel.h"

static NSString *presentcellId = @"presentcellId";
static NSString *HeaderCellId = @"HeaderCellId";
static NSString *cellId = @"cellId";
static NSString *hotelCellId = @"hotelCellId";

extern NSString *const CRABusinessAreaListSelectedNotification;
extern NSString *const CRABusinessAreaListDeselectedNotification;

@interface CRABusinessViewController ()<UITableViewDataSource,UITableViewDelegate,CRABusinessHeaderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) CRABusinessHeaderView * headerView;
//跳转的tableView
@property (nonatomic, weak) UITableView *presentTableView;

@property (nonatomic, strong) NSArray <CRAHomeTotalModel *> *guessList;
@end

@implementation CRABusinessViewController{

    NSArray<CRACitiesModel *> *_selectedCitiesList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    [self loadNetData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 加载网络数据
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
    
    // 猜你喜欢 数据
    NSArray <CRAHomeTotalModel *> *guessArray = [NSArray yy_modelArrayWithClass:[CRAHomeTotalModel class] json:data[@"guess"][@"list"]];
    _guessList = guessArray;
    
    // 写入缓存
    [data writeToFile:cachePath atomically:YES];
    
    // 重新加载数据
    [self.tableView reloadData];
}

#pragma mark-加载数据
- (void) loadData {

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"cities.plist" withExtension:nil];
    NSArray *list = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in list) {
        CRACitiesModel *model = [CRACitiesModel new];
        [model yy_modelSetWithDictionary:dict];
        [arrayM addObject:model];
    }
    _selectedCitiesList = arrayM.copy;

}

#pragma mark- CRABusinessHeaderViewDelegate
- (void)businessHeaderViewWillDisplayAreaListTableView {

    if (_presentTableView != nil) {
        [_presentTableView removeFromSuperview];
        _presentTableView = nil;
        return;
    }
    
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(2, 35, 90, self.view.bounds.size.height) style:UITableViewStylePlain];
    tv.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    
    tv.dataSource = self;
    tv.delegate = self;
   
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:presentcellId];
    [self.view addSubview:tv];
    _presentTableView = tv;
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
    if (_presentTableView != nil) {
        CRACitiesModel *model= _selectedCitiesList[indexPath.section];
        _headerView.areaLabel.text = model.cities[indexPath.row];
        [_presentTableView removeFromSuperview];
        return;
    }
    
    Class cls = NSClassFromString(@"CRAMyOrdersViewController");
    UIViewController *vc = [cls new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}


#pragma mark-UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_presentTableView != nil) {
        return _selectedCitiesList.count;
    }
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_presentTableView != nil) {
        
        CRACitiesModel *citiesModel = _selectedCitiesList[section];
        return citiesModel.cities.count;
    }
    
    if (section == 0) {
        return 1;
    }else{
    return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL result = _tableView.dragging;
    if (_presentTableView == nil || result) {
        
        [_presentTableView removeFromSuperview];
        _presentTableView = nil;

        CRABussinessCell *cell = [tableView dequeueReusableCellWithIdentifier:hotelCellId forIndexPath:indexPath];
       
        cell.model = _guessList[indexPath.row % 4];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:presentcellId forIndexPath:indexPath];
    
    CRACitiesModel *citiesModel = _selectedCitiesList[indexPath.section];
    NSString *name = citiesModel.cities[indexPath.row];
    cell.textLabel.text = name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_presentTableView != nil) {
        return 0;
    }
    return 30;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (_presentTableView != nil) {
        
        CRACitiesModel *citiesModel = _selectedCitiesList[section];
        
        return citiesModel.name;
    }
    if (section == 0) {
        return @"热门酒店";
    }else {
        return @"猜你喜欢";
    }
}

//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    if (_presentTableView != nil) {
//        
//        NSArray *names = [_selectedCitiesList valueForKey:@"name"];
//        return names;
//    }
//    return nil;
//}
#pragma mark - 设置界面
- (void)setupUI {
    
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tv];
    
    tv.bounces  = NO;
    //记录成员变量
    _tableView = tv;
    tv.estimatedRowHeight = 120;
    tv.rowHeight = UITableViewAutomaticDimension;;

    CRABusinessHeaderView *v =[CRABusinessHeaderView loadHeaderView];
    v.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    tv.tableHeaderView = v;
    v.delegate = self;
    //设置代理
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.tableView.mas_top);
        make.left.mas_equalTo(self.tableView.mas_left);
        make.width.mas_equalTo(self.tableView.mas_width);
        make.height.mas_equalTo(50);
    }];
    
    [tv registerNib:[UINib nibWithNibName:@"CRABussinessCell" bundle:nil] forCellReuseIdentifier:hotelCellId];
    tv.dataSource = self;
    tv.delegate = self;
    
    //记录成员变量
    _headerView = v;
}

@end
