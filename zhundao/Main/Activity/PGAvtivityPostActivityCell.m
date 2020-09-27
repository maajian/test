#import "PGSwappableImageView.h"
#import "PGAvtivityPostActivityCell.h"
@interface PGAvtivityPostActivityCell()
@end
@implementation PGAvtivityPostActivityCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
+ (instancetype)cellAllocWithTableView:(UITableView *)tableView WithIndexPath :(NSIndexPath *)indexpath
{
    PGAvtivityPostActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%li%li",NSStringFromClass([self class]),(long)indexpath.section,(long)indexpath.row]];
    if (!cell) {
        cell = [[PGAvtivityPostActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%li%li",NSStringFromClass([self class]),(long)indexpath.section,(long)indexpath.row]];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
