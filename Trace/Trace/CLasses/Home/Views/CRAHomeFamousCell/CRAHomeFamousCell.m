//
//  CRAHomeFamousCell.m
//  Home完整版
//
//  Created by Arvin on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeFamousCell.h"
#import "CRAHomeTotalModel.h"
#import "UIImageView+CZ_WebImage.h"
#import "CRAHomeStartScoreView.h"

@interface CRAHomeFamousCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@property (weak, nonatomic) IBOutlet CRAHomeStartScoreView *levelView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation CRAHomeFamousCell

/**
 *  纯代码入口
 *
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cz_randomColor];
    }
    return self;
}

/**
 *  Xib入口
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setModel:(CRAHomeTotalModel *)model {
    _model = model;
    
    if (model != nil) {
        
        _nameLabel.text = model.name;
        _introLabel.text = model.intro;
        [_coverImage cz_setImageWithURLString:model.cover];
        
        _distanceLabel.text = [NSString stringWithFormat:@"距离 %zd 米", arc4random_uniform(200) + 200];
        _levelView.startCount = model.score;
    }
    
    
}

@end
