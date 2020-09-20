//
//  PGActivityMessageContentCell.m
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGActivityMessageContentCell.h"

@interface PGActivityMessageContentCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation PGActivityMessageContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self initLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark --- lazyload
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = kColorA(30, 30, 30, 1);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:12];
    }
    return _statusLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.statusLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.leading.equalTo(self.contentView).offset(15);
        make.trailing.equalTo(self.contentView).offset(-15);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark --- 赋值
- (void)setModel:(PGActivityMessageContentModel *)model {
    _model = model;
    self.titleLabel.text = model.es_content;
    
    if (model.isSystem) {
        [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
        }];
        
        switch (model.messageStatusType) {
            case PGMessageStatusTypeSuccess:
                self.statusLabel.text = @"【审核通过】";
                self.statusLabel.textColor = [UIColor ZDGreenNormalColor];
                self.titleLabel.textColor = [UIColor blackColor];
                break;
            case PGMessageStatusTypeFail:
                self.statusLabel.text = [NSString stringWithFormat:@"【审核失败,含敏感词汇%@】", model.Reason];
                self.statusLabel.textColor = [UIColor ZDRedNormalColor];
                self.titleLabel.textColor = ZDGrayColor;
                break;
            case PGMessageStatusTypeCheck:
                self.statusLabel.text = @"【正在审核】";
                self.statusLabel.textColor = [UIColor ZDBlueNormalColor];
                self.titleLabel.textColor = ZDGrayColor;
                break;
            default:
                break;
        }
    }
    
     [self layoutIfNeeded];
    _model.cellHeight = self.statusLabel.maxY;
    
}


@end
