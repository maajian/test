//
//  PGMePersonInfoCell.h
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGMePersonInfoModel.h"
@interface PGMePersonInfoCell : UITableViewCell
/*! 左边label */
@property(nonatomic,strong)UILabel *leftLabel;
/*! 右边label */
@property(nonatomic,strong)UILabel *rightLabel;
/*! 第几个cell */
@property(nonatomic,assign)NSInteger cellTag;

@property(nonatomic,strong)PGMePersonInfoModel *model;

@property(nonatomic,copy)NSArray *leftArray;
@end
