//
//  CRAMXNWeViewCell.m
//  Trace
//
//  Created by Clark on 16/6/18.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CRAMXNWeViewCell.h"

@implementation CRAMXNWeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {

    _weImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 8, 24, 24)];
    [self.contentView addSubview:_weImageView];
    _weLabel = [[UILabel alloc] initWithFrame:CGRectMake(48, 0, 80, 40)];
    [self.contentView addSubview:_weLabel];
}



@end
