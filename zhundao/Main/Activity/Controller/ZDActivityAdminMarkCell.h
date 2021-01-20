//
//  ZDActivityAdminMarkCell.h
//  zhundao
//
//  Created by maj on 2021/1/9.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDActivityAdminMarkModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZDActivityAdminMarkCell;
@protocol ZDActivityAdminMarkCellDelegate <NSObject>
// 点击保存
- (void)activityAdminMarkCell:(ZDActivityAdminMarkCell *)activityAdminMarkCell didTapSaveButton:(UIButton *)saveButton;

@end

@interface ZDActivityAdminMarkCell : UITableViewCell
@property (nonatomic, strong) ZDActivityAdminMarkModel *model;
@property (nonatomic, weak) id<ZDActivityAdminMarkCellDelegate> activityAdminMarkCellDelegate;

@end

NS_ASSUME_NONNULL_END
