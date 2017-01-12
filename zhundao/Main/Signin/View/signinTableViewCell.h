//
//  signinTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "signinModel.h"
@interface signinTableViewCell : UITableViewCell
@property(nonatomic,strong)signinModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tpyeLabel;

@property (weak, nonatomic) IBOutlet UILabel *signobjectLabel;
@property (weak, nonatomic) IBOutlet UIButton *saoButton;
@property (weak, nonatomic) IBOutlet UIButton *signcountLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@end
