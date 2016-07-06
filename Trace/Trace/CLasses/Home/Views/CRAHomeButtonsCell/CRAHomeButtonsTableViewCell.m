//
//  CRAHomeButtonsTableViewCell.m
//  Trace
//
//  Created by Arvin on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeButtonsTableViewCell.h"
#import "CRAHomeTotalModel.h"
#import "CRAHomeButtonCellCollectionViewCell.h"

/**
 *  可重用标识符
 */
static NSString *CRAHomeButtonCellCollectionViewCellId = @"CRAHomeButtonCellCollectionViewCellId";

/**
 *  点击collection选中的cell,传递cell对应的模型
 */
NSString *const CRAHomeButtonsCellCollectionSelected = @"CRAHomeButtonsCellCollectionSelected";

#pragma mark - 类种类 进行布局
@interface CRACollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation CRACollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGRect rect = self.collectionView.bounds;
    
    self.itemSize =  CGSizeMake(rect.size.width / 4, rect.size.height / 2) ;
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

@end

@interface CRAHomeButtonsTableViewCell ()  <UICollectionViewDelegate, UICollectionViewDataSource>
/**
 *  记录当前collectionView,让网络加载完数据后,刷新item,
 */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CRAHomeButtonsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setCircleModelList:(NSArray<CRAHomeTotalModel *> *)circleModelList {
    
    _circleModelList = circleModelList;
    
    if (circleModelList != nil) {
        [_collectionView reloadData];
    }
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRAHomeButtonCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CRAHomeButtonCellCollectionViewCellId forIndexPath:indexPath];
    
    if (_circleModelList != nil) {
        
        cell.model = _circleModelList[indexPath.row];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate 发送通知
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"当前选中的是>>>%@", _circleModelList[indexPath.row].title);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CRAHomeButtonsCellCollectionSelected object:_circleModelList[indexPath.row] userInfo:nil];
}


#pragma mark - 设置界面
- (void)setupUI {
    
    // 底部是 collectionView
    CRACollectionViewFlowLayout *flowLayout = [[CRACollectionViewFlowLayout alloc] init];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.contentView addSubview:cv];
    
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    // 注册
    [cv registerNib:[UINib nibWithNibName:@"CRAHomeButtonCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CRAHomeButtonCellCollectionViewCellId];
    
    // 设置数据源和代理
    cv.dataSource = self;
    cv.delegate = self;
    
    // 设置属性
    cv.scrollEnabled = NO;
    cv.showsHorizontalScrollIndicator = NO;
    cv.showsVerticalScrollIndicator = NO;
    cv.backgroundColor = [UIColor whiteColor];
    
    _collectionView = cv;
    
}

@end
