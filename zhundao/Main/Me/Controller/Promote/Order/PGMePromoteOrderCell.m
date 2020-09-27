#import "PGAlertWithTitle.h"
#import "PGMePromoteOrderCell.h"
@interface PGMePromoteOrderCell()
@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) NSMutableArray <UILabel *> *leftLabelArray;
@property (nonatomic, strong) NSMutableArray <UILabel *> *rightLabelArray;
@end
@implementation PGMePromoteOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = ZDBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = 5;
        _cornerView.backgroundColor = [UIColor whiteColor];
        _cornerView.layer.masksToBounds = YES;
    }
    return _cornerView;
}
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowOpacity = 0.1;
        _shadowView.layer.shadowRadius = 5;
    }
    return _shadowView;
}
#pragma mark --- UI
- (void)PG_setupUI {
    _leftLabelArray = [NSMutableArray array];
    _rightLabelArray  = [NSMutableArray array];
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.cornerView];
    NSArray *titleArray = @[@"订单编号", @"商品名称", @"支付金额", @"所属用户", @"购买时间"];
    for (int i = 0; i < 5; i++) {
        UILabel *label = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        [self.cornerView addSubview:label];
        label.tag = 100 + i;
        label.text = titleArray[i];
        [_leftLabelArray addObject:label];
    }
    for (int i = 0; i < 5; i++) {
        UILabel *label = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
        [self.cornerView addSubview:label];
        label.tag = 200 + i;
        [_rightLabelArray addObject:label];
    }
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.leading.equalTo(self.contentView).offset(13);
        make.trailing.equalTo(self.contentView).offset(-13);
        make.bottom.mas_equalTo(0);
    }];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [_leftLabelArray mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:9 leadSpacing:9 tailSpacing:9];
    [_leftLabelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.cornerView.mas_leading).offset(18);
    }];
    [_rightLabelArray mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:9 leadSpacing:9 tailSpacing:9];
    [_rightLabelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.cornerView.mas_trailing).offset(-18);
    }];
}
#pragma mark --- setter
- (void)setModel:(PGMePromoteOrderModel *)model {
    _model = model;
    _rightLabelArray[0].text = model.OutTradeNo;
    _rightLabelArray[1].text = model.Name;
    _rightLabelArray[2].text = [NSString stringWithFormat:@"¥%f", model.Total];
    _rightLabelArray[3].text = model.NickName;
    _rightLabelArray[4].text = model.AddTime;
}
#pragma mark --- action
@end
