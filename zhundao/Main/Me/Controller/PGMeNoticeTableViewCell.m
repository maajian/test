#import "PGMeNoticeTableViewCell.h"
@implementation PGMeNoticeTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.bottomLabel];
    }
    return self;
}
- (void)setModel:(PGMeNoticeModel *)model{
    if (model) {
        _model = model;
    }
    self.topLabel.text = model.Title;
    _topLabel.font = [UIFont systemFontOfSize:14];
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeState"];
    if ([array containsObject:@(model.ID)]) {
        _topLabel.textColor = kColorA(150, 150, 150, 1);
    }else{
        _topLabel.textColor = kColorA(46, 46, 46, 1);
    }
    _topLabel.textAlignment = NSTextAlignmentLeft;
    _topLabel.numberOfLines = 0 ;
    self.bottomLabel.text = _timeText;
    _bottomLabel.font = [UIFont systemFontOfSize:12];
    _bottomLabel.textColor = kColorA(150, 150, 150, 1);
    _bottomLabel.textAlignment = NSTextAlignmentLeft;
}
#pragma mark ---懒加载
- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _bottomLabel;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (_bottomLabel) {
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(12);
            make.right.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(-4);
            make.height.mas_equalTo(20);
        }];
       [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentView).offset(12);
           make.right.equalTo(self.contentView).offset(0);
           make.top.equalTo(self.contentView).offset(4);
           make.bottom.equalTo(_bottomLabel.mas_top).offset(0);
       }];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end