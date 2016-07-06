//
//  CRAHomeGuessCell.m
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeGuessCell.h"
#import "CRAHomeTotalModel.h"
#import "UIImageView+CZ_WebImage.h"
#import "CRAHomeStartScoreView.h"

@interface CRAHomeGuessCell()
/**
 *  视频图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *foodView;
/**
 *  食品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  星级视图
 */
@property (weak, nonatomic) IBOutlet CRAHomeStartScoreView *scoreView;
/**
 *  食品描述
 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/**
 *  距离图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *distanceView;
/**
 *  距离
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation CRAHomeGuessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CRAHomeTotalModel *)model {
    _model = model;
    if (model != nil) {
        
        
        [_foodView cz_setImageWithURLString:model.cover];
        
        _titleLabel.text = model.name;
        
        _descLabel.text = model.intro;
        
        _distanceLabel.text = [NSString stringWithFormat:@"距离 %zd 米", arc4random_uniform(200) + 200];
        
        _scoreView.startCount = model.score;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
