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

@property (weak, nonatomic) IBOutlet UIButton *signcountLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@property (weak, nonatomic) IBOutlet UIButton *signname;

@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

@property (weak, nonatomic) IBOutlet UILabel *hadSignLabel;

@property (weak, nonatomic) IBOutlet UILabel *willSignLabel;

@property (weak, nonatomic) IBOutlet UILabel *signRatioLabel;

@property(nonatomic,assign)NSInteger signid ;

- (void)getData;
@end
