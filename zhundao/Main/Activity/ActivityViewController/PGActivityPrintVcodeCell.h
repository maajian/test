//
//  PGActivityPrintVcodeCell.h
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGActivityListModel.h"
@interface PGActivityPrintVcodeCell : UITableViewCell
@property(nonatomic,strong)PGActivityListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *CountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *pOneButton;
@property (weak, nonatomic) IBOutlet UIButton *pMoreButton;

@end
