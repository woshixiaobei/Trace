//
//  CRAWeViewController.m
//  Trace
//
//  Created by Arvin on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAWeViewController.h"
#import "CRAMXNWeViewCell.h"
#import "CRAWeModel.h"
#import "MXNLoginController.h"
#define MXNAlreadyLogined @"MXNAlreadyLogined"
static NSString *cellId = @"cellId";
@interface CRAWeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableview;
@property (nonatomic, strong) CRAWeModel *selectedModel;

@end

@implementation CRAWeViewController {
    NSArray *_weList;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    [self loadDataWithPlistName:@"functionSettings.plist"];
    // Do any additional setup after loading the view.
    
}
#pragma mark - 加载数据
- (void)loadDataWithPlistName:(NSString *)plistName {

    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
   
    NSArray *list = [NSArray arrayWithContentsOfURL:url];

    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSArray *array in list) {
        
        NSMutableArray *group = [NSMutableArray array];

        for (NSDictionary *dict in array) {
            
            CRAWeModel *model = [[CRAWeModel alloc] init];
           
            [model setValuesForKeysWithDictionary:dict];
            
            [group addObject:model];
        }

        [arrayM addObject:group];
    }
    _weList = arrayM.copy;
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    NSArray *group = _weList[indexPath.section];
//    NSLog(@"%zd",indexPath.section);
    // 1.获取偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 2.读取数据
    BOOL Logined = [defaults boolForKey:MXNAlreadyLogined];
    _selectedModel = group[indexPath.row];
    if (!Logined && indexPath.section == 1) {
        [self.navigationController pushViewController:[[MXNLoginController alloc] init] animated:YES];
        return;
    }
    
    Class cls = NSClassFromString(self.selectedModel.pushVCName);
    NSAssert([cls isSubclassOfClass:[UIViewController class]], @"指定的类的类型不正确 %@", self.selectedModel.pushVCName);
    
    UIViewController *vc = [[cls alloc] init];
    
//    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return _weList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *group = _weList[section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    CRAMXNWeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    NSArray *group = _weList[indexPath.section];
    
    CRAWeModel *model = group[indexPath.row];
    
    cell.weImageView.image = [UIImage imageNamed:model.icon];
    
    cell.weLabel.text = model.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor cz_colorWithRed:11/255.0 green:181/255.0 blue:252/255.0];
    
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.view addSubview:tv];
    tv.showsVerticalScrollIndicator = NO;
    tv.showsHorizontalScrollIndicator = NO;
    tv.sectionHeaderHeight = 6;
    tv.sectionFooterHeight = 0;
    tv.backgroundColor = [UIColor whiteColor];
    [tv registerClass:[CRAMXNWeViewCell class] forCellReuseIdentifier:cellId];
    
    tv.dataSource = self;
    tv.delegate = self;
    
    _tableview = tv;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
