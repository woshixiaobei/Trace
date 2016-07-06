//
//  CHCircleJudgeDetailHeaderCellTableViewCell.m
//  CircleLifeApp
//
//  Created by CrazyHacker on 16/6/22.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "CHCircleJudgeDetailHeaderCellTableViewCell.h"
@implementation CHCircleJudgeDetailHeaderCellTableViewCell {
    NSArray *_faultTimeArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _faultTimeArr = [self faultTimeValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setJudgementCount:(NSArray *)judgementCount {
    _judgementCount = judgementCount;
    
    switch (judgementCount.count) {
        case 1: if (_index == 1) {
            [self setupTrueCellWithCell:self];
        } else {
            [self setupFaulseCellWithCell:self];
        }
            break;
        case 2: if (_index >= 3) {
            [self setupFaulseCellWithCell:self];
        } else {
            [self setupTrueCellWithCell:self];
        }
            break;
        case 3: if (_index > 3) {
            [self setupFaulseCellWithCell:self];
        } else {
            [self setupTrueCellWithCell:self];
        }
            break;
        case 0:
            [self setupFaulseCellWithCell:self];
            break;
            default:
            [self setupTrueCellWithCell:self];
            break;
    }

}

- (void)setupTrueCellWithCell:(CHCircleJudgeDetailHeaderCellTableViewCell *)cell {
    self.userNameLabel.text = [self userNameFromStandard];
    self.uploadTimeLabel.text = [self loadCurrentTimeWith:[NSDate date]];
    self.judgementContent.text = _judgementCount[_index - 1];
}

- (void)setupFaulseCellWithCell:(CHCircleJudgeDetailHeaderCellTableViewCell *)cell {
    NSArray *nameArr = @[@"林志玲",@"黄圣依",@"乔吉拉德"];
    cell.userNameLabel.text = [NSString stringWithFormat:@"%@",nameArr[arc4random_uniform(3)]];
    
    self.uploadTimeLabel.text = [NSString stringWithFormat:@"%@",_faultTimeArr[arc4random_uniform(3)]];
    
    NSArray *contentArr = @[@"一袭白衣吐蕊心, 幽香自来献殷勤, 月下群芳睡梦去, 昙花一现悯谁卿",@"黑夜期待你倾国倾城的姽婳, 你恋上黑夜苍凉寂寥的静谧",@"月光下你恍若白衣仙女下凡, 过客俗世凡间, 不与群芳争妍, 不食人间烟火, 故此赢得世人, “月下美人”之誉"];
    self.judgementContent.text = [NSString stringWithFormat:@"%@", contentArr[arc4random_uniform(3)]];
}

#pragma mark - get userName from userDefaults
- (NSString *)userNameFromStandard {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 从沙河获取用户名
    NSString *userName = [defaults objectForKey:MXNUserName];
    if (userName.length > 0) {
        return userName;
    }
    return @"大美妞";
}

#pragma mark - 假时间数据
- (NSArray *)faultTimeValue {
    NSMutableArray *timeArr = [NSMutableArray array];
    NSDate *date;
    for (NSInteger i = 0; i < 3; i++) {
        date = [NSDate dateWithTimeIntervalSinceNow:arc4random_uniform(1000000) + 3333];
        [timeArr addObject:[self loadCurrentTimeWith:date]];
    }
    return timeArr.copy;
}

#pragma mark - 获取当前时间
- (NSString *)loadCurrentTimeWith:(NSDate *)date {
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"MM-dd HH:mm";
    NSString *currentTime = [formater stringFromDate:date];
    return currentTime;
}

@end
