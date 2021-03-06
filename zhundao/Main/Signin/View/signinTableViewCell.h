//
//  signinTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDSignInModel.h"

@class signinTableViewCell;
@protocol signinTableViewCellDelegate <NSObject>
- (void)signinCell:(signinTableViewCell *)signinCell willPushList:(id)sender;
- (void)signinCell:(signinTableViewCell *)signinCell willTapSwitch:(UISwitch *)signSwicth;
- (void)signinCell:(signinTableViewCell *)signinCell willShowAlert:(id)sender;

@end

@interface signinTableViewCell : UITableViewCell
@property(nonatomic,strong) ZDSignInModel *model;
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

@property (nonatomic, weak) id<signinTableViewCellDelegate> signinCellDelegate;

- (void)getData;
@end
