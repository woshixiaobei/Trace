//
//  MXNAlertView.m
//  ddddd
//
//  Created by Clark on 16/6/21.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "MXNAlertView.h"

#define BOTTOM_LEFT 12.f   //底部弹窗距离屏幕左边距
#define ALERT_HEIGHT 180.f //中间弹窗的高度
#define TITLE_LEFT 30.f    //标题距离屏幕左边距
#define TITLE_TOP 30.f     //标题纵坐标
#define TITLE_HEIGHT 30.f  //标题高度
#define MESSAGE_HEIGHT 50.f//消息高度
#define MESSAGE_TOP 10.f   //消息与标题的间距
#define BUTTON_GAP 13.f    //两个按钮之间的间距
#define BUTTON_HEIGTH 30.f //按钮高度
#define BUTTON_TOP 15.f    //按钮纵坐标
#define CENTER_LEFT 20.f   //中间弹窗距离屏幕左边距

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface MXNButton : UIButton
- (void)configButtonWithBackgroundImage:(NSString *)imageName target:(id)target;
@end

@interface UIView (Efficiency)
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat x_max;
@property (nonatomic) CGFloat y_max;
@end

static CGFloat const cellHeigth = 50.f;
static CGFloat const lineDashHeight = 2.f;

@interface MXNAlertView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) UIImageView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) MXNButton *firstBtn;
@property (nonatomic, strong) MXNButton *secondBtn;
@property (nonatomic, assign) AlertViewType alertViewType;
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) NSArray *actionTitles;
@end

@implementation MXNAlertView
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.message.length == 0) {
        self.messageLabel.height = 0;
        self.firstBtn.y = self.titleLabel.y_max + BUTTON_TOP * _ratio;
        self.secondBtn.y = self.firstBtn.y;
        self.alertView.frame = CGRectMake(CENTER_LEFT, (SCREEN_HEIGHT - self.firstBtn.y_max + 15)/2, SCREEN_WIDTH - 2*CENTER_LEFT, self.firstBtn.y_max + 15);
    }
}

- (instancetype)initWithFrame:(CGRect)frame actions:(NSArray<NSString *> *)actionTitles type:(AlertViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.3;
        self.backgroundColor = [UIColor blackColor];
        self.alertViewType = type;
        [self initAlertViewWithActionTitles:actionTitles];
    }
    return self;
}

- (void)initAlertViewWithActionTitles:(NSArray<NSString *> *)actionTitles
{
    if (self.alertViewType == AlertViewTypeCenter) {
        [self configCenterAlertView:actionTitles];
    }
    else if (self.alertViewType == AlertViewTypeBottom) {
        [self configBottomAlertView:actionTitles];
    }
}

- (void)show
{
    if (self.alertViewType == AlertViewTypeCenter) {
        [self showCenterAlertView];
    }
    else if (self.alertViewType == AlertViewTypeBottom) {
        [self showBottomAlertView];
    }
}

- (void)dismiss
{
    if (self.alertViewType == AlertViewTypeCenter) {
        [self dismissCenterAlertView];
    }
    else if (self.alertViewType == AlertViewTypeBottom) {
        [self dismissBottomAlertView];
    }
    self.actionDelegate = nil;
}

#pragma mark
#pragma mark -- Center AlertView
- (void)configCenterAlertView:(NSArray<NSString *> *)actionTitles
{
    NSAssert(actionTitles.count < 3, @"actionTitles shouldn't be more than three");
    _ratio = [UIScreen mainScreen].bounds.size.height / 667;
    [self initSubviews];
    [self.firstBtn setTitle:actionTitles.firstObject forState:UIControlStateNormal];
    [self.secondBtn setTitle:actionTitles.lastObject forState:UIControlStateNormal];
}

- (void)initSubviews
{
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.messageLabel];
    [self.alertView addSubview:self.firstBtn];
    [self.alertView addSubview:self.secondBtn];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = message;
}

- (void)showCenterAlertView
{
    NSAssert(_title != nil && _message != nil, @"title and message can't be nil");
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
    self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    [UIView animateWithDuration:0.28 animations:^{
        self.alertView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismissCenterAlertView
{
    [self.alertView removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark
#pragma mark -- Lazy Loading
- (UIImageView *)alertView
{
    if (_alertView == nil) {
        _alertView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2*CENTER_LEFT, ALERT_HEIGHT*_ratio)];
        _alertView.center = self.center;
        _alertView.userInteractionEnabled = YES;
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.contentMode = UIViewContentModeScaleAspectFit;
        _alertView.layer.cornerRadius = _ratio * 20;
        _alertView.layer.borderColor = [UIColor orangeColor].CGColor;
        _alertView.layer.borderWidth = 3;
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_LEFT, _ratio*TITLE_TOP, _alertView.width - 2 * CENTER_LEFT, _ratio*TITLE_HEIGHT)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:25.f];
        _titleLabel.textColor = [UIColor orangeColor];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT, _titleLabel.y_max + _ratio*MESSAGE_TOP, _alertView.width - 2*TITLE_LEFT, _ratio*MESSAGE_HEIGHT)];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor orangeColor];
        _messageLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _messageLabel;
}

- (MXNButton *)firstBtn
{
    if (_firstBtn == nil) {
        _firstBtn = [MXNButton buttonWithType:UIButtonTypeCustom];
        _firstBtn.frame = CGRectMake(TITLE_LEFT, _messageLabel.y_max + _ratio*BUTTON_TOP, (_alertView.width - 2*TITLE_LEFT - BUTTON_GAP) / 2, _ratio*BUTTON_HEIGTH);
        _firstBtn.tag = 0;
        [_firstBtn configButtonWithBackgroundImage:@"alert_button_xiugai" target:self];
    }
    return _firstBtn;
}

- (MXNButton *)secondBtn
{
    if (_secondBtn == nil) {
        _secondBtn = [MXNButton buttonWithType:UIButtonTypeCustom];
        _secondBtn.frame = CGRectMake(_firstBtn.x_max + BUTTON_GAP, _firstBtn.y, _firstBtn.width, _firstBtn.height);
        _secondBtn.tag = 1;
        [_secondBtn configButtonWithBackgroundImage:@"alert_button_denglu" target:self];
    }
    return _secondBtn;
}

- (void)clickedActionDelegate:(UIButton *)button
{
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(selectedCenterActionIndex:)]) {
        [self.actionDelegate selectedCenterActionIndex:button.tag];
        [self dismiss];
    }
}

#pragma mark
#pragma mark -- Bottom AlertView
- (void)configBottomAlertView:(NSArray<NSString *> *)actionTitles
{
    NSAssert(actionTitles.count != 0, @"actionTitles can't be nil");
    _actionTitles = actionTitles;
    NSInteger count = actionTitles.count;
    CGFloat viewHeight = count * cellHeigth - lineDashHeight;
    self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(BOTTOM_LEFT, SCREEN_HEIGHT, SCREEN_WIDTH - 2 * BOTTOM_LEFT, viewHeight) style:UITableViewStylePlain];
    [self setUpTableView];
}

- (void)setUpTableView
{
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.tabView.layer.cornerRadius = 20;
    self.tabView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.tabView.layer.borderWidth = 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _actionTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIndentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentify];
    }
    [self configCell:cell index:indexPath.row];
    return cell;
}

- (void)configCell:(UITableViewCell *)cell index:(NSInteger)index
{
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:18.f];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.text = _actionTitles[index];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _actionTitles.count - 1) {
        return cellHeigth - lineDashHeight;
    }
    return cellHeigth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(selectedBottomActionIndex:)]) {
        [self.actionDelegate selectedBottomActionIndex:indexPath.row];
        [self dismiss];
    }
}

- (void)showBottomAlertView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tabView];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.tabView.frame;
        frame.origin.y = SCREEN_HEIGHT - _tabView.height - BOTTOM_LEFT;
        self.tabView.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissBottomAlertView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.tabView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        self.tabView.frame = frame;
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.tabView removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.alertViewType == AlertViewTypeBottom) {
        [self dismissBottomAlertView];
    }
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end

#pragma mark
#pragma mark -- MXNButton
@implementation MXNButton
- (void)configButtonWithBackgroundImage:(NSString *)imageName target:(id)target
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:20.f];
    [self addTarget:target action:@selector(clickedActionDelegate:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
@end

#pragma mark
#pragma mark -- UIView Category
@implementation UIView (Efficiency)
@dynamic x;
@dynamic x_max;
@dynamic y;
@dynamic y_max;
@dynamic width;
@dynamic height;

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x_max
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)y_max
{
    return self.frame.origin.y + self.frame.size.height;
}



@end
