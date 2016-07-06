//
//  CRANewsPictureViewController.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsPictureViewController.h"
#import "CRANewsPictureLayout.h"
#import "CRANewsPictureCell.h"
#import "CRANewsPictureModel.h"
#import "CRANewsPictureDetailViewController.h"

static NSString *cellId = @"cellId";

@interface CRANewsPictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
//本控制器的数据
@property (nonatomic, strong) NSArray *newsPictureModels;

@end

@implementation CRANewsPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    
    // http://c.m.163.com/nc/article/list/T1356600029035/0-20.html
    
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData {
    NSString *urlString = @"http://c.m.163.com/nc/article/list/T1356600029035/0-20.html";
    NSString *channel = @"T1356600029035";
    
    [CRANewsPictureModel newsWithPictureURLString:urlString channel:channel completionHandle:^(NSArray *datas) {
       
        // 接收返回的模型数组
        self.newsPictureModels = datas;
        
        // 这里要重新使用数据
        [self.collectionView reloadData];
    }];
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    CRANewsPictureModel *model = _newsPictureModels[indexPath.row];
    
    CRANewsPictureDetailViewController *detailVC = [CRANewsPictureDetailViewController new];
    // 跳转之前传递数据
    detailVC.model = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.newsPictureModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRANewsPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    CRANewsPictureModel *model = _newsPictureModels[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CRANewsPictureLayout *layout = [[CRANewsPictureLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CRANewsPictureCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 记录
    _collectionView = collectionView;
}


@end









