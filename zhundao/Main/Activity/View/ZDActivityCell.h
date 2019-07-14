//
//  ZDActivityCell.h
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ActivityModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZDActivityCell;
@protocol ZDActivityCellDelegate <NSObject>
- (void)activityCell:(ZDActivityCell *)activityCell didTapListButton:(UIButton *)button;
- (void)activityCell:(ZDActivityCell *)activityCell didTapShareButton:(UIButton *)button;
- (void)activityCell:(ZDActivityCell *)activityCell didTapSignButton:(UIButton *)button;
- (void)activityCell:(ZDActivityCell *)activityCell didTapMoreButton:(UIButton *)button;

@end

@interface ZDActivityCell : UITableViewCell

@property (nonatomic, weak) id<ZDActivityCellDelegate> activityCellDelegate;

@property (nonatomic, strong) ActivityModel *model;

@end

NS_ASSUME_NONNULL_END
