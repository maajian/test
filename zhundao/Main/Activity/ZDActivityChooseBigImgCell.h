//
//  ZDActivityChooseBigImgCell.h
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDActivityBigImageCollectionView.h"

@protocol ChooseBigImgTableViewCellDelegate <NSObject>

- (void)selectImage :(NSString *)urlStr item :(NSInteger)item tag:(NSInteger)CollectionViewTag;

@end

@interface ZDActivityChooseBigImgCell : UITableViewCell

@property(nonatomic,weak) id<ChooseBigImgTableViewCellDelegate>  ChooseBigImgTableViewCellDelegate;

/*! 上左边的label */
@property(nonatomic,strong)UILabel *topLeftLabel ;
/*! 上右边的label */
@property(nonatomic,strong)UILabel *topRightLabel;
/*! 指向的图片 */
@property(nonatomic,strong)UIImageView *arrowImgView;
/*! cell高度 */
@property(nonatomic,assign)NSInteger height;

@property(nonatomic,assign)NSInteger section;
/*! collectView数据源 */
@property(nonatomic,assign)NSDictionary *collectDic;

/*! 第几个item */
@property(nonatomic,assign)NSInteger currentItem;
/*! 第几个CollectionView */
@property(nonatomic,assign)NSInteger currentTag;
@end
