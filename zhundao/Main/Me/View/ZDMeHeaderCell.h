//
//  ZDMeHeaderCell.h
//  zhundao
//
//  Created by maj on 2020/1/30.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDMeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDMeHeaderCell;
@protocol ZDMeHeaderCellDelegate <NSObject>
- (void)headerCell:(ZDMeHeaderCell *)headerCell didTapVIPLabel:(UILabel *)label;

@end

@interface ZDMeHeaderCell : UITableViewCell

@property (nonatomic, strong) ZDMeModel *model;
@property (nonatomic, weak) id<ZDMeHeaderCellDelegate> meHeaderCellDelegate;

@end

NS_ASSUME_NONNULL_END
