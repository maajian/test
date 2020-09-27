#import "PGDailyCourseModel.h"
#import "PGMeHeaderCell.h"
@interface PGMeHeaderCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@end
@implementation PGMeHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 33;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.borderWidth = 1;
        _iconImageView.layer.borderColor =  ZDBackgroundColor.CGColor;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor blackColor] font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _nameLabel;
}
- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor whiteColor] font:ZDSystemFont(10) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _levelLabel.layer.cornerRadius = 6;
        _levelLabel.layer.masksToBounds = YES;
        _levelLabel.backgroundColor = ZDBlueColor;
        [_levelLabel addTapGestureTarget:self action:@selector(PG_vipAction:)];
        _levelLabel.hidden = !ZD_UserM.isAdmin;
    }
    return _levelLabel;
}
- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _idLabel;
}
#pragma mark --- UI
- (void)PG_setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.levelLabel];
    [self.contentView addSubview:self.idLabel];
}
#pragma mark --- 布局
- (void)PG_initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets userTweetViewC8 = UIEdgeInsetsMake(111,103,180,240); 
        UISwitch *differenceBetweenRecti6= [[UISwitch alloc] initWithFrame:CGRectMake(143,111,150,218)]; 
    differenceBetweenRecti6.on = YES; 
    differenceBetweenRecti6.onTintColor = [UIColor whiteColor]; 
    PGDailyCourseModel *originStatusBackground= [[PGDailyCourseModel alloc] init];
[originStatusBackground interfaceOrientationMaskWithtrainCommentModel:userTweetViewC8 receiveMemoryWarning:differenceBetweenRecti6 ];
});
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(10);
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-3);
        make.height.mas_equalTo(16);
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.leading.equalTo(self.nameLabel.mas_trailing).offset(5);
        make.size.mas_equalTo(CGSizeMake(25, 12));
    }];
    [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
        make.leading.equalTo(self.nameLabel);
    }];
}
#pragma mark --- setter
- (void)setModel:(PGMeModel *)model {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets boardWithTextH3 = UIEdgeInsetsMake(125,141,255,124); 
        UISwitch *keyboardWillHidei9= [[UISwitch alloc] initWithFrame:CGRectMake(186,141,199,192)]; 
    keyboardWillHidei9.on = YES; 
    keyboardWillHidei9.onTintColor = [UIColor whiteColor]; 
    PGDailyCourseModel *registerViewModel= [[PGDailyCourseModel alloc] init];
[registerViewModel interfaceOrientationMaskWithtrainCommentModel:boardWithTextH3 receiveMemoryWarning:keyboardWillHidei9 ];
});
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:ZD_UserM.headImgUrl] placeholderImage:[UIImage imageNamed:@"user"]];
    self.nameLabel.text = ZD_UserM.nickName;
    self.levelLabel.text = [NSString stringWithFormat:@"V%li",(long)ZD_UserM.gradeId];
    self.idLabel.text = [NSString stringWithFormat:@"准到ID: %li", (long)ZD_UserM.userID];
}
#pragma mark --- Action
- (void)PG_vipAction:(UITapGestureRecognizer *)gestureRecognizer {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets styleLightContentD0 = UIEdgeInsetsMake(246,127,61,28); 
        UISwitch *withPlayerItemn8= [[UISwitch alloc] initWithFrame:CGRectMake(224,206,74,101)]; 
    withPlayerItemn8.on = YES; 
    withPlayerItemn8.onTintColor = [UIColor whiteColor]; 
    PGDailyCourseModel *statusCameraRoll= [[PGDailyCourseModel alloc] init];
[statusCameraRoll interfaceOrientationMaskWithtrainCommentModel:styleLightContentD0 receiveMemoryWarning:withPlayerItemn8 ];
});
    if ([self.meHeaderCellDelegate respondsToSelector:@selector(headerCell:didTapVIPLabel:)]) {
        [self.meHeaderCellDelegate headerCell:self didTapVIPLabel:(UILabel *)gestureRecognizer.view];
    }
}
@end
