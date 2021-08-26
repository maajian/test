//
//  ZDActivitySignCell.h
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDSignInModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDActivitySignCell;
@protocol ZDActivitySignCellDelegate <NSObject>
- (void)activitySignCell:(ZDActivitySignCell *)activitySignCell didTapMoreButton:(UIButton *)button;
- (void)activitySignCell:(ZDActivitySignCell *)activitySignCell didTapOpenSwitch:(UISwitch *)openSwitch;
- (void)activitySignCell:(ZDActivitySignCell *)activitySignCell didTapSignButton:(UIButton *)button;

@end

@interface ZDActivitySignCell : UITableViewCell
@property (nonatomic, weak) id<ZDActivitySignCellDelegate> activitySignCellDelegate;
@property (nonatomic, strong) ZDSignInModel *signInModel;

@end

NS_ASSUME_NONNULL_END
