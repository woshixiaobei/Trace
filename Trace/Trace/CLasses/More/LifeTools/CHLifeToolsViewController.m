//
//  CHLifeToolsViewController.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/20.
//  Copyright © 2016年 CrazyHacker. All rights reserved.


#import "CHLifeToolsViewController.h"
#import "CHLifeToolsCell.h"
#import "CRANetWorkManager.h"
#import "CHLifeToolsMdoel.h"
#import "CHLifeToolsDetailViewController.h"

static NSString *cellId = @"cellId";
@interface CHLifeToolsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation CHLifeToolsViewController {
    NSArray <CHLifeToolsMdoel *>*_lifeList;
    UICollectionView *_cv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"生活工具";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    [self loadData];
    [self setupUI];
}

- (void)loadData {
    // 1. 设置网络接口
    NSDictionary *dict = @{@"anu":@"api/1/index/get_index_info"};
    [[CRANetworkManager sharedManager] dataListWithType:@"circleData" parameters:dict completion:^(NSDictionary *dicts, NSError *error) {
        if (error != nil) {
            NSLog(@"==> 请求错误%@",error);
            return;
        }
        NSLog(@"==> 请求成功");
        
        // 返回的是字典数据 -- 需要字典转模型
        NSArray *arr = dicts[@"list"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            CHLifeToolsMdoel *model = [CHLifeToolsMdoel new];
            
            [model setValuesForKeysWithDictionary:dict];
            [arrayM addObject:model];
        }
        NSLog(@"字典转模型 array = %@",arrayM);
        
        _lifeList = arrayM.copy;
        [_cv reloadData];
    }];
//  [[CRANetWorkManager sharedManager] postLifeDataWithCompletion:^(NSDictionary *dict, NSError *error) {
//      if (error != nil) {
//          NSLog(@"==> 请求错误%@",error);
//          return;
//      }
//      NSLog(@"==> 请求成功");
//      
//      // 返回的是字典数据 -- 需要字典转模型
//      NSArray *arr = dict[@"list"];
//      NSMutableArray *arrayM = [NSMutableArray array];
//      for (NSDictionary *dict in arr) {
//          CHLifeToolsMdoel *model = [CHLifeToolsMdoel new];
//          
//          [model setValuesForKeysWithDictionary:dict];
//          [arrayM addObject:model];
//      }
//      NSLog(@"字典转模型 array = %@",arrayM);
//      
//      _lifeList = arrayM.copy;
//      [_cv reloadData];
//  }];
}
#pragma mark - UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CHLifeToolsMdoel *model = _lifeList[indexPath.row];
    // 获取当前cell
    UICollectionViewCell *cell = [_cv cellForItemAtIndexPath:indexPath];
    
    // 选中cell 做简单动画, 让界面灵活起来
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1);
    
    } completion:^(BOOL finished) {
        cell.layer.transform = CATransform3DIdentity;
    }];
    
    // 实例化详情控制器
    CHLifeToolsDetailViewController *dvc = [[CHLifeToolsDetailViewController alloc] init];
    dvc.model = model;
    // 跳转到生活工具详情控制器
    [self.navigationController pushViewController:dvc animated:YES];
}


- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition {
    CHLifeToolsMdoel *model = _lifeList[indexPath.row];

//    NSLog(@"###%@",model.title);
}

- (void)back:(UIBarButtonItem *)item{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _lifeList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHLifeToolsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    cell.model = _lifeList[indexPath.row];
    return cell;
}

- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    CGSize size = self.view.bounds.size;
    CGFloat margin = (size.width - 2 * 20 - 3 * 75) / 3;
    layout.itemSize = CGSizeMake(75, 80);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 14, 20);
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:cv];
    cv.backgroundColor = [UIColor whiteColor];
    [cv registerClass:[CHLifeToolsCell class] forCellWithReuseIdentifier:cellId];
    cv.dataSource = self;
    cv.delegate = self;
    _cv = cv;
}
@end
