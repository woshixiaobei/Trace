//
//  CRACommunityViewController.m
//  Trace
//
//  Created by 张玺科 on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACommunityViewController.h"
#import "RZPopupMenuView.h"
#import "CRACommunityViewCell.h"
#import "CRACommunityFlowLayout.h"
#import "CRACommunityNavigationController.h"
#import "CRAHomeViewController.h"
#import "CRAMainTabBarController.h"
#import "CRAMoreModel.h"

static NSString *cellId = @"cellId";

@interface CRACommunityViewController()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray <CRAMoreModel *>*moreList;;

@end
@implementation CRACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"社区服务";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    
    [self loadData];
    
    [self setupUI];
    
    

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSIndexPath *path = [NSIndexPath indexPathForItem:indexPath.item inSection:0];
    
    //跳转下一个控制器
    Class cls = NSClassFromString(@"CRAMoreViewController");
    UIViewController *vc = [cls new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)back:(UIBarButtonItem *)item{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark-UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRACommunityViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    //设置cell
    cell.model = _moreList[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

#pragma mark-加载数据
- (void) loadData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"service.plist" withExtension:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfURL:url];
    NSArray *list = [NSArray yy_modelArrayWithClass:[CRAMoreModel class] json:array];
    self.moreList = [NSArray arrayWithArray:list].copy;
}

#pragma mark-搭建界面
- (void)setupUI {
    
    CRACommunityFlowLayout *layout = [[CRACommunityFlowLayout alloc]init];
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    cv.backgroundColor = [UIColor whiteColor];
    cv.userInteractionEnabled = YES;
    [self.view addSubview:cv];
    
    //注册可重用cell
    [cv registerClass:[CRACommunityViewCell class] forCellWithReuseIdentifier:cellId];
    cv.dataSource = self;
    cv.delegate = self;
    //自动布局
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
@end
