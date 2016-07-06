//
//  CHLifeToolsDetailCell.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHLifeToolsDetailCell.h"

@interface CHLifeToolsDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end

@implementation CHLifeToolsDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *arr = @[@"秦皇岛大酒店",@"梅特艾森",@"中央大剧院",@"海地原始森林",@"希尔顿大酒店",@"	情侣酒店",@"半岛酒店"];
    _titleLabel.text = [NSString stringWithFormat:@"%@",arr[arc4random_uniform(6)]];
    for (NSString *name in arr) {
        _titleLabel.text = name;
    }
    
    _currentTimeLabel.text = [self getCurrentTime];
    _distanceLabel.text = [NSString stringWithFormat:@"距离: %zd米", arc4random_uniform(400) + 50];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getCurrentTime {
    
    NSDate* now = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
   return [fmt stringFromDate:now];
}
@end
