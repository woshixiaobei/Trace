//
//  CRAPayViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAPayViewController.h"
#import "CRAmyOrdersCell.h"
#import "CRAMyOrderListViewModel.h"

NSString *payCellId = @"payCellId";

@interface CRAPayViewController ()

@end

@implementation CRAPayViewController{

    NSMutableArray <CRAMyOrderListViewModel *>*_MyOrderViewList;
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
     
    NSMutableArray *arrayM =[NSMutableArray array];
    for (NSDictionary *dict in list) {
       
        CRAMyOrderListViewModel *model =[CRAMyOrderListViewModel new];
        [model setValuesForKeysWithDictionary:dict];
        [arrayM addObject:model];
    }
    _MyOrderViewList = arrayM.copy;
}
#pragma mark-代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    

}

#pragma mark-数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _MyOrderViewList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CRAmyOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:payCellId forIndexPath:indexPath];
    
    cell.model = _MyOrderViewList[indexPath.row];
    
    return cell;

}
#pragma mark-搭建界面
- (void)setupUI {

    [self.tableView registerNib:[UINib nibWithNibName:@"CRAmyOrdersCell" bundle:nil] forCellReuseIdentifier:payCellId];
//    self.tableView.rowHeight = 80;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

@end
