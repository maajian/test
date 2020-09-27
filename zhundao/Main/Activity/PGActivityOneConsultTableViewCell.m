#import "PGRecoderSelectPicker.h"
#import "PGActivityOneConsultTableViewCell.h"
#import "PGActivityOneConsultViewModel.h"
@interface PGActivityOneConsultTableViewCell()
@end
@implementation PGActivityOneConsultTableViewCell
- (void)awakeFromNib {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange mutableVideoCompositiona1 = NSMakeRange(7,83); 
        CGPoint orderDetailCellN1 = CGPointMake(1,250); 
    PGRecoderSelectPicker *progressUpdateBlock= [[PGRecoderSelectPicker alloc] init];
[progressUpdateBlock updateStatuMandatoryWithcolumnistChildView:mutableVideoCompositiona1 integralRecordData:orderDetailCellN1 ];
});
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange timeModelDatac4 = NSMakeRange(10,72); 
        CGPoint postImageWithR9 = CGPointMake(2,90); 
    PGRecoderSelectPicker *readingMutableContainers= [[PGRecoderSelectPicker alloc] init];
[readingMutableContainers updateStatuMandatoryWithcolumnistChildView:timeModelDatac4 integralRecordData:postImageWithR9 ];
});
    [super setSelected:selected animated:animated];
}
- (void)setModel:(PGActivityConsultModel *)model
{
    if (model) {
        _model= model;
    }
    switch (self.tag) {
        case 0:{
            [self.contentView addSubview:self.imgView];
            [self.contentView addSubview:self.nameLabel];
            [self.contentView addSubview:self.phoneLabel];
            [self.contentView addSubview:self.questionLabel];
            [self.contentView addSubview:self.timeLabel];
        }
            break;
        case 1:{
            [self.contentView addSubview:self.textView];
        }
            break;
        case 2:{
            [self.contentView addSubview:self.mySwitch];
            [self.contentView addSubview:self.remLabel];
        }
            break;
        default:
            break;
    }
}
#pragma mark ----懒加载 
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.HeadImgurl]];
    }
    return _imgView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[ UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = _model.NickName;
        _nameLabel.textColor = [UIColor darkTextColor];
    }
    return _nameLabel;
}
- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = [UIColor blueColor];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.text = _model.Phone;
    }
    return _phoneLabel;
}
- (UILabel *)questionLabel
{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.font = [UIFont systemFontOfSize:14];
        _questionLabel.text = _model.Question;
        _questionLabel.numberOfLines = 0 ;
    }
    return _questionLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = _timeStr;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _textView.textContainerInset = UIEdgeInsetsMake(5,10, 5, 10);
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.scrollEnabled = YES;
        if (_model.Answer) {
            _textView.text = _model.Answer;
            _textView.textColor = [UIColor blackColor];
        }else{
            _textView.text = @"请输入要回复的内容";
            _textView.textColor = [UIColor lightGrayColor];
        }
    }
    return _textView;
}
- (UILabel *)remLabel{
    if (!_remLabel) {
        _remLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];
        _remLabel.text = @"设为推荐";
        _remLabel.font = [UIFont systemFontOfSize:16];
    }
    return _remLabel;
}
- (UISwitch *)mySwitch{
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-60, 7, 60, 44)];
        if (_model.IsRecommend) {
            _mySwitch.on = YES;
        }else{
            _mySwitch.on = NO;
        }
    }
    return _mySwitch;
}
- (void)layoutSubviews{
    if (_timeLabel) {
        __weak typeof(_imgView) weakView = _imgView;
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(0.12);
            make.left.equalTo(self.contentView).offset(8);
            make.height.equalTo(weakView.mas_width);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.mas_right).offset(8);
            make.width.mas_equalTo(60);
            make.top.equalTo(self.contentView).offset(8);
            make.height.mas_equalTo(20);
        }];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right).offset(8);
            make.right.equalTo(self.contentView).offset(-8);
            make.top.equalTo(self.contentView).offset(8);
            make.height.mas_equalTo(20);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.mas_right).offset(8);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.right.equalTo(self.contentView).offset(-8);
            make.height.mas_equalTo(20);
        }];
        [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
            make.bottom.mas_equalTo(self.timeLabel.mas_top).offset(-5);
            make.left.mas_equalTo(_imgView.mas_right).offset(8);
            make.right.mas_equalTo(self.contentView).offset(-8);
        }];
    }
}
@end
