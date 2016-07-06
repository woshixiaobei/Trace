//
//  CRACircleHomeFlowLayout.m
//  Trace
//
//  Created by 小贝 on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACircleHomeFlowLayout.h"

@implementation CRACircleHomeFlowLayout

- (void)prepareLayout {

    [super prepareLayout];
    
    CGSize size = self.collectionView.bounds.size;
    NSInteger count = 4;
    
    CGFloat margin = 20;
    int itemW = (size.width - (count -1) *margin ) / count;
    
    self.itemSize = CGSizeMake(itemW, itemW + 40);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    self.sectionInset = UIEdgeInsetsMake(30, 10, 0, 10 );
    
}

@end
