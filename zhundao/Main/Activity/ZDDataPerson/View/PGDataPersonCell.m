#import "PGOrganizeListView.h"
#import "PGDataPersonCell.h"
@interface PGDataPersonCell()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@end
@implementation PGDataPersonCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:PGMediumFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _numberLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:PGMediumFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _timeLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    }
    return _phoneLabel;
}
- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _statusLabel.layer.cornerRadius = 4;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.layer.borderWidth = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
#pragma mark --- UI
- (void)PG_setupUI {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * taskCenterTablez4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    taskCenterTablez4.contentMode = UIViewContentModeCenter; 
    taskCenterTablez4.clipsToBounds = NO; 
    taskCenterTablez4.multipleTouchEnabled = YES; 
    taskCenterTablez4.autoresizesSubviews = YES; 
    taskCenterTablez4.clearsContextBeforeDrawing = YES; 
        UITableView *withRenderingModeA4= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    withRenderingModeA4.frame = CGRectZero; 
    withRenderingModeA4.showsVerticalScrollIndicator = NO; 
    withRenderingModeA4.showsHorizontalScrollIndicator = NO; 
    withRenderingModeA4.backgroundColor = [UIColor whiteColor]; 
    withRenderingModeA4.separatorColor = [UIColor whiteColor]; 
    withRenderingModeA4.tableFooterView = [UIView new]; 
    withRenderingModeA4.estimatedRowHeight =98; 
    withRenderingModeA4.estimatedSectionHeaderHeight =54; 
    withRenderingModeA4.estimatedSectionFooterHeight =51; 
    withRenderingModeA4.rowHeight =44; 
    withRenderingModeA4.sectionFooterHeight =41; 
    withRenderingModeA4.sectionHeaderHeight =41; 
    withRenderingModeA4.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(60,224,59,97)];
     withRenderingModeA4.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(49,93,32,143)];
     PGOrganizeListView *lightOraneColor= [[PGOrganizeListView alloc] init];
[lightOraneColor deviceSettingsTypeWithlaunchViewController:taskCenterTablez4 deepBlackColor:withRenderingModeA4 ];
});
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.statusLabel];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(40);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.numberLabel.mas_trailing).offset(0);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-3);
        make.trailing.equalTo(self.phoneLabel.mas_leading).offset(-10);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(3);
        make.leading.equalTo(self.nameLabel);
        make.trailing.equalTo(self.statusLabel.mas_leading).offset(-10);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.nameLabel);
        make.width.mas_equalTo(90);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.phoneLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
}
#pragma mark --- setter
- (void)setModel:(PGDataPersonModel *)model {
    _model = model;
    _numberLabel.text = [NSString stringWithFormat:@"%li", (long)model.number];
    _nameLabel.text = model.UserName;
    _timeLabel.text = model.AddTime;
    _phoneLabel.text = model.Phone;
    switch (model.dataPersonStatus) {
        case ZDDataPersonStatusReview:
            _statusLabel.text = @"待审核";
            _statusLabel.textColor = [UIColor colorFromHexCode:@"EF9740"];
            _statusLabel.layer.borderColor = [UIColor colorFromHexCode:@"EF9740"].CGColor;
            break;
        case ZDDataPersonStatusReject:
            _statusLabel.text = @"已拒绝";
            _statusLabel.textColor = [UIColor colorFromHexCode:@"E64340"];
            _statusLabel.layer.borderColor = [UIColor colorFromHexCode:@"E64340"].CGColor;
            break;
        case ZDDataPersonStatusPass:
            _statusLabel.text = @"已通过";
            _statusLabel.textColor = [UIColor colorFromHexCode:@"09BB07"];
            _statusLabel.layer.borderColor = [UIColor colorFromHexCode:@"09BB07"].CGColor;
            break;
        default:
            break;
    }
}
#pragma mark --- action
@end
