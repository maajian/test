//
//  ZDDiscoverCustomCell.h
//  zhundao
//
//  Created by zhundao on 2017/1/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDDiscoverCustomModel.h"
@interface ZDDiscoverCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *boolLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property(nonatomic,strong)ZDDiscoverCustomModel *model;
@end
