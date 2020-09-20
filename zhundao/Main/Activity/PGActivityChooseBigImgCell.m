#import "PGOrderWithPayment.h"
//
//  PGActivityChooseBigImgCell.m
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityChooseBigImgCell.h"
#import "PGActivityBigImageFlowLayout.h"
@interface PGActivityChooseBigImgCell()<imageSelectDelegate>
/*! 流水布局 */
@property(nonatomic,strong)PGActivityBigImageFlowLayout *flowLayout;

@property(nonatomic,strong)PGActivityBigImageCollectionView *collectView;

@end
@implementation PGActivityChooseBigImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.arrowImgView];
        [self.contentView addSubview:self.topLeftLabel];
        [self.contentView addSubview:self.topRightLabel];
        [self.contentView addSubview:self.collectView];
    }
    return self;
}

#pragma mark --- 懒加载

- (UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc]initWithFrame: CGRectMake(kScreenWidth-20, 17, 10, 10)];
        _arrowImgView.image = [UIImage imageNamed:@"rightArrows"];
    }
    return _arrowImgView;
}
- (UILabel *)topRightLabel{
    if (!_topRightLabel) {
        _topRightLabel = [MyLabel initWithLabelFrame:CGRectMake(100, 0, kScreenWidth-130, 44) Text:@"建议尺寸600*400" textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
    }
    return _topRightLabel;
}

- (UILabel *)topLeftLabel{
    if (!_topLeftLabel) {
        _topLeftLabel  =[MyLabel initWithLabelFrame:CGRectMake(20, 0, 80, 44) Text:@"上传" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _topLeftLabel;
}

- (PGActivityBigImageCollectionView *)collectView {
    if (!_collectView) {
        _flowLayout = [[PGActivityBigImageFlowLayout alloc]init];
        _collectView = [[PGActivityBigImageCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _height) collectionViewLayout:_flowLayout];
    }
    return _collectView;
}

- (void)setSection:(NSInteger)section{
    if (section==0) {
        _collectView.hidden= YES;
        _topLeftLabel.hidden = NO;
        _topRightLabel.hidden = NO;
        _arrowImgView.hidden = NO;
        return;
    }
        _collectView.hidden = NO;
        _collectView.currentItem = _currentItem;
        _collectView.imageSelectDelegate = self;
        _collectView.tag = section+100;
        _collectView.currentTag = _currentTag;
        _topLeftLabel.hidden = YES;
        _topRightLabel.hidden = YES;
         _arrowImgView.hidden = YES;
        _collectView.dataArray = _collectDic[@"List"];
        _collectView.headerTitle = _collectDic[@"Category"];
        [_collectView reloadData];
    
}

- (void)selectIndex:(NSString *)urlStr item :(NSInteger)item tag:(NSInteger)CollectionViewTag{
    if ([self.ChooseBigImgTableViewCellDelegate respondsToSelector:@selector(selectImage:item:tag:)]) {
        [self.ChooseBigImgTableViewCellDelegate selectImage:urlStr item:item  tag:CollectionViewTag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectView.frame = CGRectMake(0, 0, kScreenWidth, _height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
