//
//  ZDActivityAdminMarkCell.m
//  zhundao
//
//  Created by maj on 2021/1/9.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityAdminMarkCell.h"

@interface ZDActivityAdminMarkCell()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation ZDActivityAdminMarkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- init
- (void)initUI {
    self.textField = [[UITextField alloc] init];
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textColor = [UIColor blackColor];
    self.textField.delegate = self;
    [self.contentView addSubview:self.textField];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 120)];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.showsVerticalScrollIndicator = YES;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.textColor = [UIColor blackColor];
    self.textView.delegate = self;
    [self.contentView addSubview:self.textView];
    
    self.saveButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageWithColor:ZDGreenColor] target:self action:@selector(saveAction:)];
    self.saveButton.backgroundColor = ZDGreenColor;
    self.saveButton.layer.cornerRadius = 4;
    self.saveButton.layer.masksToBounds = YES;
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.saveButton];
}
- (void)initLayout {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.top.bottom.equalTo(self.contentView);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.trailing.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(100);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth * 0.8);
        make.center.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark --- setter
- (void)setModel:(ZDActivityAdminMarkModel *)model {
    _model = model;
    if (model.type == ZDAdminMarkTypeMark ) {
        self.textField.hidden = YES;
        self.textView.hidden = NO;
        self.textView.text = model.content;
        self.saveButton.hidden = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
    } else if (model.type == ZDAdminMarkTypeSave) {
        self.textField.hidden = YES;
        self.textView.hidden = YES;
        self.saveButton.hidden = NO;
        self.textField.placeholder = @"";
        self.textField.text = @"";
        self.contentView.backgroundColor = ZDBackgroundColor;
    } else {
        self.textField.hidden = NO;
        self.textView.hidden = YES;
        self.saveButton.hidden = YES;
        self.textField.placeholder = model.placeHolder;
        self.textField.text = model.content;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark --- UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    _model.content = textView.text;
}

#pragma mark --- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _model.content = textField.text;
}

#pragma mark --- action
- (void)saveAction:(UIButton *)button {
    if ([self.activityAdminMarkCellDelegate respondsToSelector:@selector(activityAdminMarkCell:didTapSaveButton:)]) {
        [self.activityAdminMarkCellDelegate activityAdminMarkCell:self didTapSaveButton:button];
    }
}

@end
