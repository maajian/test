//
//  AllAccountTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AllAccountTableViewCell.h"

@implementation AllAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconimageView];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

- (void)setModel:(AllAccountModel *)model{
    if (model) {
        _model = model;
    }
    if ([_model.BankName isEqualToString:@"支付宝"]) {
        _iconimageView.image = [UIImage imageNamed:@"支付宝"];
        _rightLabel.text =[NSString stringWithFormat:@"%@(%@)",model.Account,model.BankName] ;
    } else if([_model.BankName isEqualToString:@"微信钱包"]){
        _iconimageView.image = [UIImage imageNamed:@"wechatWithDraw"];
        _rightLabel.text =[NSString stringWithFormat:@"%@",model.Account] ;
    } else{
        _iconimageView.image = [UIImage imageNamed:@"银行卡"];
        _rightLabel.text =[NSString stringWithFormat:@"%@(%@)",model.Account,model.BankName] ;
    }
    
}


- (UIImageView *)iconimageView{
    if (!_iconimageView) {
        _iconimageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 20, 20)];
    }
    return _iconimageView;
}

- (UILabel *)rightLabel{
    if (!_rightLabel ) {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, kScreenWidth-40, 44)];
    }return _rightLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
