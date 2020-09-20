//
//  ZDDiscoverFaceDetailCell.h
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDDiscoverFaceModel.h"
@interface ZDDiscoverFaceDetailCell : UITableViewCell


@property(nonatomic,strong)ZDDiscoverFaceModel *model;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UIButton *signButton;

@end
