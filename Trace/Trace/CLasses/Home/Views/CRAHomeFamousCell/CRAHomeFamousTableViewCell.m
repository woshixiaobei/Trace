//
//  CRAHomeFamousTableViewCell.m
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeFamousTableViewCell.h"
#import "CRAHomeFamousCell.h"
#import "CRAHomeTotalModel.h"

/**
 *  点击collection选中的cell,传递cell对应的模型
 */
NSString *const CRAHomeFamousCellCollectionSelected = @"CRAHomeFamousCellCollectionSelected";

@interface CRAHomeFamousTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

/**
 *  记录当前collectionView,让网络加载完数据后,刷新item,
 */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation CRAHomeFamousTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

- (void)setFamousModelList:(NSArray<CRAHomeTotalModel *> *)famousModelList {
    _famousModelList = famousModelList;
    
    if (_famousModelList != nil) {
        [_collectionView reloadData];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_famousModelList == nil) {
        return 4;
    }
    
    return _famousModelList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRAHomeFamousCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFamousCellId" forIndexPath:indexPath];
    
    if (_famousModelList != nil) {
        
        cell.model = _famousModelList[indexPath.row];
    }
    
    
    return cell;

}

#pragma mark - UICollectionViewDelegate 发送通知
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"当前选中的是>>>%@", _famousModelList[indexPath.row].name);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CRAHomeFamousCellCollectionSelected object:_famousModelList[indexPath.row] userInfo:nil];
}

#pragma mark - 设置界面
- (void)setupUI {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 178) collectionViewLayout:flowLayout];
    
    cv.backgroundColor = [UIColor cz_colorWithHex:0xEAEAEA];

    [self.contentView addSubview:cv];

    [cv registerNib:[UINib nibWithNibName:@"CRAHomeFamousCell" bundle:nil] forCellWithReuseIdentifier:@"HomeFamousCellId"];
    
    cv.dataSource = self;
    cv.delegate = self;
    
    flowLayout.itemSize = CGSizeMake(cv.bounds.size.width / 2 - 0.5, cv.bounds.size.height / 2);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    
    cv.scrollEnabled = NO;
    cv.showsVerticalScrollIndicator = NO;
    
    
    _collectionView = cv;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}




@end
