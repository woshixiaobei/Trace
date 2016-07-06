//
//  CRAHomeButtonCellCollectionViewCell.m
//  Trace
//
//  Created by Arvin on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAHomeButtonCellCollectionViewCell.h"
#import "CRAHomeTotalModel.h"
#import "UIImageView+CZ_WebImage.h"

@interface CRAHomeButtonCellCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation CRAHomeButtonCellCollectionViewCell

- (void)setModel:(CRAHomeTotalModel *)model {
    _model = model;
    
    if (model != nil) {
        
    [_iconImage cz_setImageWithURLString:model.cover];
        
    _titleLable.text = model.title;
        
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
