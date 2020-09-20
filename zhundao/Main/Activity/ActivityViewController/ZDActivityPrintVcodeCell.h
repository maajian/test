//
//  ZDActivityPrintVcodeCell.h
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDActivityListModel.h"
@interface ZDActivityPrintVcodeCell : UITableViewCell
@property(nonatomic,strong)ZDActivityListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *CountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *pOneButton;
@property (weak, nonatomic) IBOutlet UIButton *pMoreButton;

@end
