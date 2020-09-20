//
//  ZDMePersonInfoCell.h
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDMePersonInfoModel.h"
@interface ZDMePersonInfoCell : UITableViewCell
/*! 左边label */
@property(nonatomic,strong)UILabel *leftLabel;
/*! 右边label */
@property(nonatomic,strong)UILabel *rightLabel;
/*! 第几个cell */
@property(nonatomic,assign)NSInteger cellTag;

@property(nonatomic,strong)ZDMePersonInfoModel *model;

@property(nonatomic,copy)NSArray *leftArray;
@end
