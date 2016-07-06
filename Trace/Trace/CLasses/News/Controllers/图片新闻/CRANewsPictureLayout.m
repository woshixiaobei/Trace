//
//  CRANewsPictureLayout.m
//  News
//
//  Created by 杨应海 on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsPictureLayout.h"

@implementation CRANewsPictureLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat margin = 10;
    
    CGFloat width = self.collectionView.bounds.size.width;
    CGFloat sizeW = (width - 3 * margin) / 2;
    CGFloat sizeH = 190;
    
    self.itemSize = CGSizeMake(sizeW, sizeH);
    self.minimumLineSpacing = 20;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
}


@end






