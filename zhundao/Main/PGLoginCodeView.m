//
//  WYMeCodeView.m
//  Meari
//
//  Created by maj on 2019/4/11.
//  Copyright © 2019 Meari. All rights reserved.
//

#import "PGLoginCodeView.h"

static const NSInteger itemCount = 4;
static const CGFloat fixedSpace = 10.f;

@interface PGLoginCodeView()<UITextFieldDelegate> {
    NSInteger _selectIndex; // 当前位置
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *maskButton;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *lineArray;
@property (nonatomic, assign, getter=isDelete) BOOL delete;

@end

@implementation PGLoginCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _selectIndex = 0;
        _labelArray = [NSMutableArray array];
        _lineArray = [NSMutableArray array];
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.textField];
    [self addSubview:self.maskButton];
    for (int i = 0; i < itemCount; i++) {
        UILabel *codeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(24) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        [self addSubview:codeLabel];
        [self.labelArray addObject:codeLabel];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ZDLineColor;
        [self addSubview:lineView];
        [self.lineArray addObject:lineView];
    }
}

#pragma mark --- 布局
- (void)initLayout {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.labelArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:fixedSpace leadSpacing:0 tailSpacing:0];
    [self.labelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    [self.lineArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:fixedSpace leadSpacing:0 tailSpacing:0];
    [self.lineArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark --- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self changeAnimation:textField];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_selectIndex >= 0 && _selectIndex < self.lineArray.count) {
        [self.lineArray[_selectIndex].layer removeAllAnimations];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"text = %@",textField.text);
    if ([string isEqualToString:@""] && range.location == 0 && range.length == 0) {
        return NO;
    }
    _delete = range.length == 1;  // 是否是删除
    if ((range.location == itemCount - 1 && range.length == 0) || range.location == itemCount) {
        // 最后一个数字输入处理
        textField.text = [[textField.text substringToIndex:itemCount - 1] stringByAppendingString: string];
        self.labelArray[itemCount - 1].text = string;
        [self.textField resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark --- action
- (void)textFieldEditingDidChanged:(UITextField *)textField {
    if ([textField.text isEqualToString:@""] && _selectIndex == itemCount - 1) {
        return;
    }
    _selectIndex = textField.text.length >= itemCount ? itemCount: textField.text.length; // 当前位置修改;
    if (self.isDelete) {
        if (_selectIndex >= 0 && _selectIndex < self.labelArray.count) {
            self.labelArray[_selectIndex].text = @"";
        }
    } else if(_selectIndex > 0){
        self.labelArray[_selectIndex - 1].text = [textField.text substringFromIndex:_selectIndex - 1];
    }
    //直接从键盘粘贴
    if (_selectIndex == itemCount) {
        for (int i = 0; i < itemCount; i ++) {
            [self.lineArray[i].layer removeAllAnimations];
            self.labelArray[i].text = [textField.text substringWithRange:NSMakeRange(i, 1)];
        }
        _selectIndex = itemCount - 1;
    }
    [self removeAnimation:textField];
    [self changeAnimation:textField];
}
// 按钮点击弹出键盘
- (void)maskButtonAction:(UIButton *)button {
    [self.textField becomeFirstResponder];
}
// 横线动画
- (void)lineAnimation:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 1;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = (id)ZDLineColor.CGColor;
    animation.toValue = (id)ZDMainColor.CGColor;
    [view.layer addAnimation:animation forKey:@"backgroundColor"];
}

#pragma mark --- lazyload
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        if (@available(iOS 12.0, *)) {
            _textField.textContentType =  UITextContentTypeOneTimeCode;
        } else {
            // Fallback on earlier versions
        }
        [_textField addTarget:self action:@selector(textFieldEditingDidChanged:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _textField;
}
- (UIButton *)maskButton {
    if (!_maskButton) {
        _maskButton = [UIButton zd_button];
        _maskButton.backgroundColor = ZDBackgroundColor;
        [_maskButton addTarget:self action:@selector(maskButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskButton;
}

#pragma mark --- public
- (void)changeAnimation:(UITextField *)textField {
    if (self.isDelete) {
        [self lineAnimation:self.lineArray[_selectIndex]];
    } else {
        [self lineAnimation:self.lineArray[_selectIndex]];
    }
}
- (void)removeAnimation:(UITextField *)textField  {
    if (self.isDelete) {
        [self.lineArray[_selectIndex == itemCount -1 ? _selectIndex : _selectIndex + 1].layer removeAllAnimations];
    } else {
        if (_selectIndex) {
            [self.lineArray[_selectIndex - 1].layer removeAllAnimations];
        }
    }
}


@end
