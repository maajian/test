#import "PGTaskCenterModel.h"
//
//  payTextField.m
//  zhundao
//
//  Created by zhundao on 2017/11/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "payTextField.h"
@interface payTextField()

@property(nonatomic,assign)NSInteger blackRadius;

@end

@implementation payTextField

- (instancetype)initWithFrame:(CGRect)frame blackRadius:(NSInteger)blackRadius{
    if (self = [super initWithFrame:frame]) {
        _blackRadius = blackRadius;
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _textf = [[UITextField alloc]initWithFrame:self.bounds];
    _textf.keyboardType = UIKeyboardTypeNumberPad;
    [_textf becomeFirstResponder];
    _textf.backgroundColor = [UIColor clearColor];
    _textf.tintColor = [UIColor whiteColor];
    _textf.textColor = [UIColor whiteColor];
    [_textf addTarget:self action:@selector(TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textf];
    
    CGFloat firstCenterX = CGRectGetWidth(self.frame)/12;
    CGFloat firstCenterY = CGRectGetHeight(self.frame)/2;
    
    _label1 = [[UILabel alloc]init];
    _label1.frame =CGRectMake(firstCenterX-_blackRadius, firstCenterY-_blackRadius, 2*_blackRadius, 2*_blackRadius);
    _label1.layer.cornerRadius = _blackRadius;
    _label1.layer.masksToBounds = YES;
    _label1.backgroundColor = [UIColor blackColor];
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc]init];
    _label2.frame =CGRectMake(firstCenterX*3-_blackRadius, firstCenterY-_blackRadius,2*_blackRadius, 2*_blackRadius);
    _label2.layer.cornerRadius = _blackRadius;
    _label2.layer.masksToBounds = YES;
    _label2.backgroundColor = [UIColor blackColor];
    [self addSubview:_label2];
    
    _label3 = [[UILabel alloc]init];
    _label3.frame =CGRectMake(firstCenterX*5-_blackRadius, firstCenterY-_blackRadius, 2*_blackRadius, 2*_blackRadius);
    _label3.layer.cornerRadius = _blackRadius;
    _label3.layer.masksToBounds = YES;
    _label3.backgroundColor = [UIColor blackColor];
    [self addSubview:_label3];
    
    _label4 = [[UILabel alloc]init];
    _label4.frame =CGRectMake(firstCenterX*7-_blackRadius, firstCenterY-_blackRadius, 2*_blackRadius, 2*_blackRadius);
    _label4.layer.cornerRadius = _blackRadius;
    _label4.layer.masksToBounds = YES;
    _label4.backgroundColor = [UIColor blackColor];
    [self addSubview:_label4];
    
    _label5 = [[UILabel alloc]init];
    _label5.frame =CGRectMake(firstCenterX*9-_blackRadius, firstCenterY-_blackRadius, 2*_blackRadius, 2*_blackRadius);
    _label5.layer.cornerRadius = _blackRadius;
    _label5.layer.masksToBounds = YES;
    _label5.backgroundColor = [UIColor blackColor];
    [self addSubview:_label5];
    
    _label6 = [[UILabel alloc]init];
    _label6.frame =CGRectMake(firstCenterX*11-_blackRadius, firstCenterY-_blackRadius, 2*_blackRadius, 2*_blackRadius);
    _label6.layer.cornerRadius = _blackRadius;
    _label6.layer.masksToBounds = YES;
    _label6.backgroundColor = [UIColor blackColor];
    [self addSubview:_label6];
    
    _label1.hidden=YES;
    _label2.hidden=YES;
    _label3.hidden=YES;
    _label4.hidden=YES;
    _label5.hidden=YES;
    _label6.hidden=YES;
}

- (void)TextFieldDidChange:(UITextField *)textField{
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle assetCollectionTypey2 = UITableViewCellSeparatorStyleNone; 
        NSArray *trainCommentTablex0= [NSArray array];
    PGTaskCenterModel *numberFormatterRound= [[PGTaskCenterModel alloc] init];
[numberFormatterRound pg_fillModeBothWithassetCollectionSubtype:assetCollectionTypey2 downloadChapterModel:trainCommentTablex0 ];
});

    switch (textField.text.length) {
        case 0:
        {
            _label1.hidden=YES;
            _label2.hidden=YES;
            _label3.hidden=YES;
            _label4.hidden=YES;
            _label5.hidden=YES;
            _label6.hidden=YES;
        }
            break;
        case 1:
        {
            _label1.hidden=NO;
            _label2.hidden=YES;
            _label3.hidden=YES;
            _label4.hidden=YES;
            _label5.hidden=YES;
            _label6.hidden=YES;
        }
            break;
        case 2:
        {
            _label1.hidden=NO;
            _label2.hidden=NO;
            _label3.hidden=YES;
            _label4.hidden=YES;
            _label5.hidden=YES;
            _label6.hidden=YES;
        }
            break;
        case 3:
        {
            _label1.hidden=NO;
            _label2.hidden=NO;
            _label3.hidden=NO;
            _label4.hidden=YES;
            _label5.hidden=YES;
            _label6.hidden=YES;
        }
            break;
        case 4:
        {
            _label1.hidden=NO;
            _label2.hidden=NO;
            _label3.hidden=NO;
            _label4.hidden=NO;
            _label5.hidden=YES;
            _label6.hidden=YES;
        }
            break;
        case 5:
        {
            _label1.hidden=NO;
            _label2.hidden=NO;
            _label3.hidden=NO;
            _label4.hidden=NO;
            _label5.hidden=NO;
            _label6.hidden=YES;
        }
            break;
        case 6:
        {
            _label1.hidden=NO;
            _label2.hidden=NO;
            _label3.hidden=NO;
            _label4.hidden=NO;
            _label5.hidden=NO;
            _label6.hidden=NO;
        }
            break;
            
        default:
            break;
    }
    if (textField.text.length==6)
    {
        [_payTextFieldDelegate sendPassWord:textField.text];
        [textField resignFirstResponder];
    }
}


- (void)drawRect:(CGRect)rect{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = kColorA(120, 120, 120, 1).CGColor;
    layer.lineWidth = 0.3;
    layer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(0, 0)];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.lineWidth = 0.3;
    CGFloat spaceWidth = CGRectGetWidth(self.frame)/6;
    layer1.strokeColor = kColorA(180, 180, 180, 1).CGColor;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    for (int i = 1; i<6; i++) {
        [path1 moveToPoint:CGPointMake(spaceWidth*i, 0)];
        [path1 addLineToPoint:CGPointMake(spaceWidth*i, CGRectGetHeight(self.frame))];
    }
    layer1.path = path1.CGPath;
    [self.layer addSublayer:layer1];
}




@end
