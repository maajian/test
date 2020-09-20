//
//  PGMeMoreAccountTableViewCell.h
//  zhundao
//
//  Created by xhkj on 2018/1/23.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGMeMoreAccountModel.h"
@interface PGMeMoreAccountTableViewCell : UITableViewCell
/*! 头像 */
@property (nonatomic, strong) UIImageView *iconImageView;
/*! 姓名 */
@property (nonatomic, strong) UILabel *nameLabel;
/*! 手机 */
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) PGMeMoreAccountModel *model;

@end
