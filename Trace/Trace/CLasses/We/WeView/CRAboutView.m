//
//  CRAboutView.m
//  Trace
//
//  Created by Clark on 16/6/19.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAboutView.h"

@implementation CRAboutView


- (void)drawRect:(CGRect)rect {
//     [self setupUI];

        CGContextRef ctx = UIGraphicsGetCurrentContext();

        CGContextMoveToPoint(ctx, 0, 0);
    
        CGContextAddLineToPoint(ctx, self.bounds.size.width, 0);

        CGContextSetLineWidth(ctx, 2);

        CGFloat lengths[] = {5, 0};

        CGContextSetLineDash(ctx, 0, lengths,3);

        CGContextStrokePath(ctx);
  
}
@end
