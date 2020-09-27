#import "PGActivityJPullCell.h"
@implementation PGActivityJPullCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.frame.size.width-self.leftEdge, self.frame.size.height)];
    self.emailLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.emailLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
