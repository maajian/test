//
//  GroupSendTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "GroupSendTableViewCell.h"
@interface GroupSendTableViewCell()<UITextViewDelegate>

@end
@implementation GroupSendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftLabel1];
        [self.contentView addSubview:self.TextView];
        [self.contentView addSubview:self.wordLabel];
        [self.contentView addSubview:self.groupSign];
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.detailLabel];
        [self updataFrame];
        [self addObserver:self forKeyPath:@"labelCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (UILabel *)leftLabel1{
    if (!_leftLabel1) {
        _leftLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 44)];
        _leftLabel1.textColor = [UIColor blackColor];
        _leftLabel1.font = [UIFont systemFontOfSize:14];
    }
    return _leftLabel1;
}

- (UITextView *)TextView{
    if (!_TextView) {
        _TextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 120)];
        _TextView.font = [UIFont systemFontOfSize:13];
        _TextView.showsVerticalScrollIndicator = YES;
        _TextView.editable = NO;
        _TextView.showsHorizontalScrollIndicator = NO;
        _TextView.backgroundColor = [UIColor whiteColor];
        _TextView.delegate = self;
        _TextView.textColor = zhundaoGrayColor;
        [_TextView addTapGestureTarget:self action:@selector(textViewAction:)];
    }
    return _TextView;
}

- (UILabel *)wordLabel{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc]init];
        _wordLabel.font = [UIFont systemFontOfSize:12];
        _wordLabel.textColor =kColorA(120, 120, 120, 1);
        _wordLabel.textAlignment = NSTextAlignmentRight;
    }
    return _wordLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        _rightLabel.textColor = kColorA(120, 120, 120, 1);
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 44)];
        _detailLabel.textColor = kColorA(120, 120, 120, 1);
        _detailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailLabel;
}

- (UILabel *)groupSign{
    if (!_groupSign) {
        _groupSign = [[UILabel alloc]init];
        _groupSign.font = [UIFont systemFontOfSize:12];
        _groupSign.textColor =kColorA(120, 120, 120, 1);
        _groupSign.textAlignment = NSTextAlignmentLeft;
    }
    return _groupSign;
}

#pragma mark --- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    if (_signStr.length+_TextView.text.length>200) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"字数超过限制"];
        [label labelAnimationWithViewlong:self];
        [self endEditing:YES];
    }
    if (_signStr.length+_TextView.text.length<=70) {
        self.labelCount = 1;
    }else if (_signStr.length+_TextView.text.length<=140){
        self.labelCount = 2;
    }else{
        self.labelCount = 3;
    }
    _wordLabel.text = [NSString stringWithFormat:@"共%li个字/分为%li条",_signStr.length+_TextView.text.length,_labelCount];
    [self attributeForWordLabel:_wordLabel.text];
    
}

#pragma mark --- 存取器重写

- (void)setIndexPath:(NSIndexPath *)indexPath{
    if (_signStr.length+_textStr.length<=70) {
        _labelCount = 1;
    }else if (_signStr.length+_textStr.length<=140){
        _labelCount = 2;
    }else{
        _labelCount = 3;
    }
    _indexPath = indexPath;
    if (_indexPath.section==0) {
        _TextView.hidden = YES;
        _detailLabel.hidden = YES;
        _wordLabel.hidden = YES;
        _groupSign.hidden = YES;
        _leftLabel1.text = @"选择收信人";
        _rightLabel.text = [NSString stringWithFormat:@"已选%li人",_personCount];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section ==1){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _leftLabel1.hidden = YES;
        _detailLabel.hidden = YES;
        _rightLabel.hidden = YES;
        _TextView.text = _textStr;
        _wordLabel.text = [NSString stringWithFormat:@"共%li个字/分为%li条",_signStr.length+_TextView.text.length,_labelCount];
        _groupSign.text = [NSString stringWithFormat:@" 群发签名: %@",_signStr];
        NSString *str = _groupSign.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_groupSign.text];
        [attributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} range:[str rangeOfString:_signStr]];
        _groupSign.attributedText = attributedString;
        [self attributeForWordLabel:_wordLabel.text];
    }else if (indexPath.section==2 && indexPath.row==0){
        _detailLabel.hidden = YES;
        _TextView.hidden = YES;
        _wordLabel.hidden = YES;
        _groupSign.hidden = YES;
        _leftLabel1.text = @"本次群发订单";
        _rightLabel.text = @"短信包余额不足";
        _rightLabel.textColor = kColorA(233, 97, 111, 1);
        _rightLabel.font = [UIFont systemFontOfSize:13];
        if (_messageCount>_labelCount*_personCount) {
            _rightLabel.hidden = YES;
        }
    }else{
        _leftLabel1.hidden = YES;
        _wordLabel.hidden = YES;
        _TextView.hidden = YES;
        _groupSign.hidden = YES;
        if (indexPath.row==1) {
            _detailLabel.text = @"*收信人数";
            _rightLabel.text = [NSString stringWithFormat:@"%li人",_personCount];
        }else if (indexPath.row ==2){
            _detailLabel.text = @"*文本条数";
            _rightLabel.text = [NSString stringWithFormat:@"x %li条",_labelCount];
        }else{
            
            NSString *str = [NSString stringWithFormat:@"短信包当前余额 : %li条",_messageCount];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
            [attributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                              NSFontAttributeName : [UIFont systemFontOfSize:17]
                                              } range:NSMakeRange(9, str.length-10)];
            _detailLabel.attributedText = attributedString;
            [self attributeForRightLabel:_rightLabel];
        }
    }
}

/*! wordLabel 的富文本 */

- (void)attributeForWordLabel:(NSString *)str{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:14]} range:[str rangeOfString:[NSString stringWithFormat:@"%li",_signStr.length+_TextView.text.length]]];
     [attributedString addAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:14]} range:NSMakeRange(str.length-2, 1)];
    _wordLabel.attributedText = attributedString;
}

- (void)attributeForRightLabel:(UILabel *)label{
    NSString *rightStr = [NSString stringWithFormat:@"合计: %li条",_personCount*_labelCount];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:rightStr];
    [attributedString1 addAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                       NSFontAttributeName : [UIFont systemFontOfSize:17]
                                       } range:[rightStr rangeOfString:[NSString stringWithFormat:@"%li",_personCount*_labelCount]]];
    label.attributedText = attributedString1;
}

#pragma mark --- 更新约束 设置大小

- (void)updataFrame{
    [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-3);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
    [_groupSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-3);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(150);
    }];
    
}

#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    UITableView *tableView;
    UIResponder *responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UITableView class]]) {
             tableView = (UITableView *)responder;
            break;
        }
        responder = responder.nextResponder;
    }
    GroupSendTableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    GroupSendTableViewCell *cell2 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
    cell1.rightLabel.text = [NSString stringWithFormat:@"x %@条",[ change valueForKey:NSKeyValueChangeNewKey]];
    cell2.rightLabel.text = [NSString stringWithFormat:@"合计: %li条",_personCount*[[ change valueForKey:NSKeyValueChangeNewKey]integerValue]];
    [self attributeForRightLabel:cell2.rightLabel];
     GroupSendTableViewCell *cell3 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (_personCount*[[ change valueForKey:NSKeyValueChangeNewKey]integerValue]>_messageCount) {
        cell3.rightLabel.hidden = NO;
    }else{
        cell3.rightLabel.hidden = YES;
    }
    if (_groupSendBlock) {
        _groupSendBlock(_labelCount,_TextView.text);
    }
}

#pragma mark --- action
- (void)textViewAction:(UITextView *)textview {
    if ([self.groupSendTableViewCellDelegate respondsToSelector:@selector(tableViewCell:didSelectTextView:)]) {
        [self.groupSendTableViewCellDelegate tableViewCell:self didSelectTextView:textview];
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"labelCount"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
