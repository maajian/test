#import "PGActivityBuyMessageCell.h"
@implementation PGActivityBuyMessageCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.textf];
        [self.contentView addSubview:self.label2];
    }
    return self;
}
- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc]init];
        _label1.text = @"自定义";
        _label1.font = [UIFont systemFontOfSize:14];
        CGSize size = [_label1.text boundingRectWithSize:CGSizeMake(1000, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size;
        _label1.frame = CGRectMake(16, 0, size.width, 44);
    }
    return _label1;
}
- (UITextField *)textf{
    if (!_textf) {
        _textf = [myTextField initWithFrame:CGRectMake(CGRectGetMaxX(_label1.frame), 0, 80, 44) placeholder:nil font:[UIFont systemFontOfSize:14] TextAlignment:NSTextAlignmentCenter textColor:[UIColor darkGrayColor]];
        _textf.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textf;
}
- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textf.frame), 0, 50, 44)];
        _label2.font = [UIFont systemFontOfSize:14];
        _label2.text = @"条";
    }
    return _label2;
}
- (void)drawRect:(CGRect)rect{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor blackColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
     CGSize size = [_label1.text boundingRectWithSize:CGSizeMake(1000, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size;
    [path moveToPoint:CGPointMake(CGRectGetMaxX(_label1.frame), 22+size.height/2)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(_label1.frame)+80, 22+size.height/2)];
    layer.path =path.CGPath;
    [self.contentView.layer addSublayer:layer];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
