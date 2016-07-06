//
//  CRABussinessCell.m
//  111
//
//  Created by 小贝 on 16/6/23.
//  Copyright © 2016年 小贝. All rights reserved.
//

#import "CRABussinessCell.h"
#import "CRAStarLevelView.h"
#import "CRASelectedItemHotelModel.h"
#import "CRAHomeTotalModel.h"
#import "UIImageView+CZ_WebImage.h"

@interface CRABussinessCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet CRAStarLevelView *starLevelView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
@implementation CRABussinessCell


- (void)setModel:(CRAHomeTotalModel *)model {
    _model = model;
    
    if (model != nil) {
        [_iconView cz_setImageWithURLString:model.cover];
        _titleLabel.text = model.name;
        
        _descLabel.text = model.intro;
        
        _distanceLabel.text = [NSString stringWithFormat:@"距离 %zd 米", arc4random_uniform(200) + 200];
        
        _starLevelView.level = model.score;

    }
    
}
@end
