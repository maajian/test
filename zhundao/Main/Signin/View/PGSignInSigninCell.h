//
//  PGSignInSigninCell.h
//  zhundao
//
//  Created by zhundao on 2016/12/9.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGSignInModel.h"

@class PGSignInSigninCell;
@protocol signinTableViewCellDelegate <NSObject>
- (void)signinCell:(PGSignInSigninCell *)signinCell willPushList:(id)sender;
- (void)signinCell:(PGSignInSigninCell *)signinCell willTapSwitch:(UISwitch *)signSwicth;
- (void)signinCell:(PGSignInSigninCell *)signinCell willShowAlert:(id)sender;

@end

@interface PGSignInSigninCell : UITableViewCell
@property(nonatomic,strong) PGSignInModel *model;
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
