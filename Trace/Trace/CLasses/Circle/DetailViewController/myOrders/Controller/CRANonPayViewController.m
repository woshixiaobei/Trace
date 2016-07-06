//
//  CRANonPayViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRANonPayViewController.h"
#import "CRAmyOrdersCell.h"
#import "CRAMyOrderListViewModel.h"

NSString *noPayCellId = @"noPayCellId";

@implementation CRANonPayViewController{
    NSArray <CRAMyOrderListViewModel *>*_myUnorderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-加载数据
- (void)loadData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CRAMyOrderListViewModel.plist" withExtension:nil];
    NSArray *list = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in list) {
        CRAMyOrderListViewModel *model = [CRAMyOrderListViewModel new];
        [model setValuesForKeysWithDictionary:dict];
        [arrayM  addObject:model];
    }
    _myUnorderList = arrayM.copy;

}
#pragma mark-代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    Class cls = NSClassFromString(@"")
}

#pragma mark-数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myUnorderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CRAmyOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:noPayCellId forIndexPath:indexPath];
    CRAMyOrderListViewModel *model = _myUnorderList[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark-搭建界面
- (void)setupUI {

    [self.tableView registerNib:[UINib nibWithNibName:@"CRAMyNoOrderCell" bundle:nil] forCellReuseIdentifier:noPayCellId];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}
@end
