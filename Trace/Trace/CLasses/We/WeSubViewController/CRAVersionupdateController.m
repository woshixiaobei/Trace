//
//  CRAVersionupdateController.m
//  Trace
//
//  Created by Clark on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAVersionupdateController.h"
#import "CRAWeVersionupdateCell.h"

static NSString *cellId = @"cellId";
static NSString *weUpdateId = @"weUpdateId";

@interface CRAVersionupdateController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) UITableView *tableview;

@end

@implementation CRAVersionupdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%zd",indexPath.section);

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *Id ;
    if (indexPath.section == 2) {
        Id = weUpdateId;
    } else {
        Id = cellId;
    
    }
    CRAWeVersionupdateCell *cell = [tableView dequeueReusableCellWithIdentifier:Id forIndexPath:indexPath];
    
    if (indexPath.section == 0) {

        cell.weVersionLeftLabel.text = @"当前版本:";
        cell.weVersionRightLabel.text = @"v5.2.05";
    }else if (indexPath.section == 1) {

    cell.weVersionLeftLabel.text = @"最新版本:";
    cell.weVersionRightLabel.text = @"v5.2.05";
    } else if (indexPath.section == 2) {
        cell.weVersionButton.layer.cornerRadius = 5;
        [cell.weVersionButton addTarget:self action:@selector(clickWeVersionButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
//    cell.textLabel.text = @(indexPath.section).description;
    return cell;
}
#pragma mark - target
- (void)clickWeVersionButton {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"这已是最新版本！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:confirm];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//      [tv deselectRowAtIndexPath:indexPath animated:YES];
    [self.view addSubview:tv];
    tv.scrollEnabled = NO;
    tv.showsVerticalScrollIndicator = NO;
    tv.showsHorizontalScrollIndicator = NO;
    tv.sectionHeaderHeight = 30;
    tv.sectionFooterHeight = 0;
    tv.rowHeight = 60;
//    [tv registerClass:[CRAWeVersionupdateCell class] forCellReuseIdentifier:cellId];
    [tv registerNib:[UINib nibWithNibName:@"CRAWeVersionupdateCell" bundle:nil] forCellReuseIdentifier:cellId];
    [tv registerNib:[UINib nibWithNibName:@"CRAWeUpdateButtonCell" bundle:nil] forCellReuseIdentifier:weUpdateId];
    tv.dataSource = self;
    tv.delegate = self;
    
    _tableview = tv;
    
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
