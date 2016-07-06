//
//  CRACircleViewController.m
//  Trace
//
//  Created by Arvin on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACircleViewController.h"
#import "CRACircleItemCell.h"
#import "CRACircleHomeFlowLayout.h"
#import "CRACircleModel.h"
#import "CRANetworkManager.h"

static NSString *cellId = @"cellId";

@interface CRACircleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray <CRACircleModel *>*circleList;;
@end

@implementation CRACircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-数据源方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //跳转下一个控制器
    Class cls = NSClassFromString(@"CRADetailViewController");
    UIViewController *vc = [cls new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark-UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _circleList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRACircleItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    CRACircleModel *model = _circleList[indexPath.item];
    
    cell.model = model;
    return cell;
    
}

#pragma mark-加载数据
- (void) loadData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"CRACircleItem.plist" withExtension:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfURL:url];
    NSArray *list = [NSArray yy_modelArrayWithClass:[CRACircleModel class] json:array];
    self.circleList = [NSMutableArray arrayWithArray:list];
    
}
#pragma mark-搭建界面
- (void)setupUI {
    
    CRACircleHomeFlowLayout *layout = [[CRACircleHomeFlowLayout alloc]init];
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    cv.backgroundColor = [UIColor whiteColor];
    cv.userInteractionEnabled = YES;
    [self.view addSubview:cv];
    
    //注册可重用cell
    [cv registerClass:[CRACircleItemCell class] forCellWithReuseIdentifier:cellId];
    cv.dataSource = self;
    cv.delegate = self;
    //自动布局
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
@end
