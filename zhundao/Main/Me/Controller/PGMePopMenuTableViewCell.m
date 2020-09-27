#import "PGMePopMenuTableViewCell.h"
@implementation PGMePopMenuTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }else {
        self.backgroundColor = [UIColor whiteColor];
    }
}
@end
