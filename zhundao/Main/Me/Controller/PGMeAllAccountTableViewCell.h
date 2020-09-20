//
//  PGMeAllAccountTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGMeAllAccountModel.h"
@interface PGMeAllAccountTableViewCell : UITableViewCell

@property(nonatomic,strong)PGMeAllAccountModel *model;
/*! 图标 */
@property(nonatomic,strong)UIImageView *iconimageView;
/*! 账户 */
@property(nonatomic,strong)UILabel *rightLabel;

@end
