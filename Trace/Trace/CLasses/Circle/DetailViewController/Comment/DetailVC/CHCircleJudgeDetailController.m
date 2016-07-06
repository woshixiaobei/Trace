//
//  CHCircleJudgeDetailController.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHCircleJudgeDetailController.h"
#import "CHCircleJudgeDetailHeaderView.h"
#import "CHCircleJudgeDetailHeaderCellTableViewCell.h"
#import "CHPresentViewController.h"
#import "CHCircleJudgeDetailFooterView.h"

#define kShared_Button_Link_XinLang_Tag 100 // XinLang tag
#define kShared_Button_Link_QZone_Tag 101   // QZone tag
#define kShared_Button_Link_DouBan_Tag 102  // DouBan tag
#define kShared_Button_Link_RenRen_Tag 103  // RenRen tag
#define kShared_Button_Link_WeChat_Tag 104  // WeChat tag
#define kShared_Button_Link_Cancle_Tag 105  // Cancle shared tag

 // standadDefault  userName key
static NSString *headerCellId = @"headerCellId";
static NSString *cellId = @"cellId";

@interface CHCircleJudgeDetailController ()<UITableViewDelegate, UITableViewDataSource, CHPresentViewControllerDelegate>

@end

@implementation CHCircleJudgeDetailController {
    /** 评论数据库 */
    NSMutableArray *_judgementList;
    /** 显示评论内容的TableView */
    UITableView *_tableView;
    /** 假时间数据 */
    NSArray *_faultTimeArr;
    /** 设置Cell数量索引 */
    NSInteger _index;
    /** 展示评论内容的数量 */
    NSInteger _count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
    
    _judgementList = [NSMutableArray array];
    _faultTimeArr = [NSArray array];
    
    _index = 0;
    _count = 3;
    [self setupUI];
}

#pragma mark - CHPresentViewControllerDelegate
- (void)presentViewController:(CHPresentViewController *)vc withButton:(UIButton *)btn {
    
    switch (btn.tag) {
        case kShared_Button_Link_XinLang_Tag:
            NSLog(@"分享到 - 新浪");
            break;
        case kShared_Button_Link_QZone_Tag:
            NSLog(@"分享到 - QZone");
            break;
        case kShared_Button_Link_DouBan_Tag:
            NSLog(@"分享到 - 豆瓣");
            break;
        case kShared_Button_Link_RenRen_Tag:
            NSLog(@"分享到 - 人人");
            
            break;
        case kShared_Button_Link_WeChat_Tag:
            NSLog(@"分享到 - 微信");
            break;
        case kShared_Button_Link_Cancle_Tag:
            NSLog(@"取消 分享");
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
    }
}

#pragma mark - 头视图 & 发表评论
- (void)showSharedView:(CHCircleJudgeDetailHeaderView *)view {
    if (view.isShowSharedView) {
        // 1. Modal 一个蒙皮视图
        CHPresentViewController *vc = [[CHPresentViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
        vc.delegate = self;
        view.isShowSharedView = NO;
    }
    // 2. 发表评论
    if (view.isUpLoadJudgement) {
        if (view.judgeContentTextView.text.length == 0) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Hi Honey!" message:@"您尚未输入任何内容,您确定要发表么？" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [_judgementList insertObject:@"" atIndex:0];
                
            }]];
            
            [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:vc animated:YES completion:nil];
        
        }
        NSString *userName = [self userNameFromStandard];
        if (userName) {
            [_judgementList insertObject:view.judgeContentTextView.text atIndex:0];
            NSLog(@"%@",_judgementList);
        }
        _index = 0;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        _index = 0;
        [_tableView reloadData];
        view.judgeContentTextView.text = nil;
        
    }
}

#pragma mark - get userName from userDefaults
- (NSString *)userNameFromStandard {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 从沙河获取用户名
    NSString *userName = [defaults objectForKey:MXNUserName];
    if (userName.length > 0) {
        return userName;
    }
    return @"大美妞";
}

#pragma mark - 底部视图的监听方法
- (void)showMoreJudgement:(CHCircleJudgeDetailFooterView *)footerView {
    _count += 1;
    _index = 0;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    _index = 0;
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHCircleJudgeDetailHeaderCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    ++_index;
    cell.index = _index;
    cell.judgementCount = _judgementList;
    return cell;
}

#pragma mark - 搭建界面
- (void)setupUI {
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    
    tv.rowHeight = 90;
    tv.showsVerticalScrollIndicator = NO;
    tv.showsHorizontalScrollIndicator = NO;
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tv registerNib:[UINib nibWithNibName:@"CHCircleJudgeDetailHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:headerCellId];
    [tv registerNib:[UINib nibWithNibName:@"CHCircleJudgeDetailHeaderCellTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    // 方法1： 从XIB 关联类中,直接创建类方法, 实例话XIB视图对象
    CHCircleJudgeDetailHeaderView * headerView = [CHCircleJudgeDetailHeaderView headerView];
    tv.tableHeaderView = headerView;
    
    // 监听方法
    [headerView addTarget:self action:@selector(showSharedView:) forControlEvents:UIControlEventValueChanged];
    
    CHCircleJudgeDetailFooterView *footerView = [CHCircleJudgeDetailFooterView footerView];
    tv.tableFooterView = footerView;
    [footerView addTarget:self action:@selector(showMoreJudgement:) forControlEvents:UIControlEventValueChanged];

    tv.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    tv.dataSource = self;
    tv.delegate = self;
    _tableView = tv;
}

@end
