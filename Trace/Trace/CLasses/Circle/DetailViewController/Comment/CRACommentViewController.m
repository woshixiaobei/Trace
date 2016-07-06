//
//  CRACommentViewController.m
//  Trace
//
//  Created by 小贝 on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACommentViewController.h"
#import "CARCricleJudgeDetailCell.h"
#import "CHCircleJudgeDetailController.h"

static NSString *cellId = @"cellId";
extern NSString *const kDidSelectedButtonToShowDetail;

@interface CRACommentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation CRACommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailViewControllers:) name:kDidSelectedButtonToShowDetail object:nil];
}

- (void)showDetailViewControllers:(NSNotification *)notification {
    UIButton *btn = notification.object;
    CHCircleJudgeDetailController *vc = [CHCircleJudgeDetailController new];
    vc.index = btn.tag;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc {
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 设置 '圈子详情控制器' 界面
- (void)setupUI {
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    [tv registerNib:[UINib nibWithNibName:@"CARCricleJudgeDetailCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    tv.estimatedRowHeight = 150;
    tv.rowHeight = UITableViewAutomaticDimension;
    tv.delegate = self;
    tv.dataSource = self;
    self.tableView = tv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CARCricleJudgeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.index = indexPath.row;
    
    return cell;
}
@end
