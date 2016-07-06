//
//  CRACommunityFlowLayout.m
//  Trace
//
//  Created by 张玺科 on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRACommunityFlowLayout.h"

@implementation CRACommunityFlowLayout
- (void)prepareLayout {
    
    [super prepareLayout];
    
    NSLog(@"%@",self.collectionView);
    CGSize size = self.collectionView.bounds.size;
    NSInteger count = 4;
    
    CGFloat margin = 10;
    int itemW = (size.width - (count -1) *margin ) / count;
    
    
    self.itemSize = CGSizeMake(itemW, itemW + 40);
    
    //设置间距
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
    
    self.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0 );
    
}
@end
