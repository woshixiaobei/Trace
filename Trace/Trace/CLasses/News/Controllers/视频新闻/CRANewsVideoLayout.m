//
//  CRANewsVideoLayout.m
//  News
//
//  Created by 杨应海 on 16/6/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsVideoLayout.h"

@implementation CRANewsVideoLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat width = self.collectionView.bounds.size.width;
    
    CGFloat margin = 10;
    
    CGFloat sizeW = (width - 3 * margin) / 2;
    CGFloat sizeH = 190;
    
    self.itemSize = CGSizeMake(sizeW, sizeH);
    self.minimumLineSpacing = 20;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(15, 10, 10, 10);
}


@end






