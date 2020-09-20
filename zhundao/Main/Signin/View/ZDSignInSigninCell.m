//
//  ZDSignInSigninCell.m
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "ZDSignInSigninCell.h"
#import "Time.h"
//#import "SignInViewModel.h"
@interface ZDSignInSigninCell()

@end

@implementation ZDSignInSigninCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setModel:(ZDSignInModel *)model
{
    if (model) {
        _model = model;
    }
    _titleLabel.text = _model.ActivityName;
    if (_model.CheckInType==0) {
        _tpyeLabel.text = @"";
    }
    else if (_model.CheckInType==1)
    {
        _tpyeLabel.text = @"";
    }
    else
    {
        _tpyeLabel.text =@"";
    }
    _switchButton.on = model.Status;
    _titleLabel.text = _model.ActivityName;
    [_signname setTitle:_model.Name forState:UIControlStateNormal];
    _signobjectLabel.text =[NSString stringWithFormat: @"全部:%li",(long)_model.NumShould];
}

- (BOOL)isShowRed{
    if (_model.NumShould ==0) {
        return NO;
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signid]]) {
        NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signid]];
        if (array.count!=_model.NumShould) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

- (void)getData{
    NSInteger all =_model.NumShould;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]] ) {
            [obj removeFromSuperlayer];
            *stop = YES;
        }
    }];
    if (all) {
        NSInteger had =_model.NumFact;
        NSInteger will =_model.NumShould - _model.NumFact;
        _hadSignLabel.text = [NSString stringWithFormat:@"已签:%li",(long)had];
        _willSignLabel.text =[NSString stringWithFormat:@"待签:%li",(long)will];
        _signRatioLabel.text = [NSString stringWithFormat:@"签到率:%.1f%%",(float)had/all*100];
    }else{
        _hadSignLabel.text =@"已签:0";
        _willSignLabel.text =@"待签:0";
        _signRatioLabel.text = @"签到率:0.0%";
    }
    [self colorSTRWithStr:_hadSignLabel rangeBegin:3];
    [self colorSTRWithStr:_willSignLabel rangeBegin:3];
    [self colorSTRWithStr:_signRatioLabel rangeBegin:4];
    [self colorSTRWithStr:_signobjectLabel rangeBegin:3];
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     if ([self isShowRed]) {
         float x;
        if (@available(iOS 11.0, *)) {
            x = kScreenWidth-100;
        }else{
            x = kScreenWidth -90;
        }
        float y = CGRectGetMinY(_signcountLabel.frame);
        CGRect rect = CGRectMake(x , y +12 , 12 , 12);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor =kColorA(238, 28, 38, 1).CGColor;
        [self.layer addSublayer:shapeLayer];
     }
}

- (void)colorSTRWithStr :(UILabel *)label rangeBegin :(NSInteger )begin
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value:ZDMainColor range:NSMakeRange(begin, label.text.length-begin)];
    label.attributedText = string;
}

#pragma mark --- Action
- (IBAction)pushSignList:(id)sender {
    if ([self.signinCellDelegate respondsToSelector:@selector(signinCell:willPushList:)]) {
        [self.signinCellDelegate signinCell:self willPushList:sender];
    }
}

- (IBAction)switchChange:(id)sender {
    if ([self.signinCellDelegate respondsToSelector:@selector(signinCell:willTapSwitch:)]) {
        [self.signinCellDelegate signinCell:self willTapSwitch:sender];
    }
}
- (IBAction)alertAction:(id)sender {
    if ([self.signinCellDelegate respondsToSelector:@selector(signinCell:willShowAlert:)]) {
        [self.signinCellDelegate signinCell:self willShowAlert:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
