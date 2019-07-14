//
//  FaceDetailTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceModel.h"
@interface FaceDetailTableViewCell : UITableViewCell


@property(nonatomic,strong)FaceModel *model;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UIButton *signButton;

@end
