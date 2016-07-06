//
//  CRANewsDetailCell.m
//  News
//
//  Created by 杨应海 on 16/6/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CRANewsDetailCell.h"
#import "CRANewRemarkModel.h"

@interface CRANewsDetailCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end


@implementation CRANewsDetailCell



- (void)setModel:(CRANewRemarkModel *)model {
    _model = model;
    
    _iconView.image = [UIImage imageNamed:model.userIcon];
    _userNameLabel.text = model.userName;
    _remarkLabel.text = model.userRemark;
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
