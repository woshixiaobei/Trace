//
//  CRAPushSettingViewController.m
//  Trace
//
//  Created by Clark on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAPushSettingViewController.h"
#import "CRAWePushSettingCell.h"
static NSString *cellId = @"cellId";
@interface CRAPushSettingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak)UITableView *tableView;
@end

@implementation CRAPushSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CRAWePushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (indexPath.section == 0) {
        
     cell.setName.text = @"允许推送";
    }else if (indexPath.section == 1) {
cell.setName.text = @"推送提示音";
    } else if (indexPath.section == 2) {
cell.setName.text = @"推送震动";
    }

    return cell;
}


- (void)setupUI {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
 
    [self.view addSubview:tv];
    tv.showsVerticalScrollIndicator = NO;
    tv.showsHorizontalScrollIndicator = NO;
    tv.sectionHeaderHeight = 30;
    tv.sectionFooterHeight = 0;
    tv.rowHeight = 60;

    [tv registerNib:[UINib nibWithNibName:@"CRAWePushSettingCell" bundle:nil] forCellReuseIdentifier:cellId];
    tv.scrollEnabled = NO;
    tv.dataSource = self;
    tv.delegate = self;
    
    _tableView = tv;
    
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
