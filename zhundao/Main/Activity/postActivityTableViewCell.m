//
//  postActivityTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/4/11.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "postActivityTableViewCell.h"
@interface postActivityTableViewCell()
@end
@implementation postActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
+ (instancetype)cellAllocWithTableView:(UITableView *)tableView WithIndexPath :(NSIndexPath *)indexpath
{
    postActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%li%li",NSStringFromClass([self class]),(long)indexpath.section,(long)indexpath.row]];
    if (!cell) {
        cell = [[postActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@%li%li",NSStringFromClass([self class]),(long)indexpath.section,(long)indexpath.row]];
    }
    
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
