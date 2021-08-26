//
//  ZDActivityMoreChioceCell.h
//  zhundao
//
//  Created by maj on 2021/3/31.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDActivityMoreChioceModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDActivityMoreChioceCell;
@protocol ZDActivityMoreChioceCellDelegate <NSObject>
// 点击开关
- (void)moreChioceCell:(ZDActivityMoreChioceCell *)moreChioceCell didChangeAlertSwitch:(UISwitch *)alertSwitch;
// 点击添加图片
- (void)moreChioceCell:(ZDActivityMoreChioceCell *)moreChioceCell didChangeImage:(UIImageView *)addImageView;

@end

@interface ZDActivityMoreChioceCell : UITableViewCell

@property (nonatomic, strong) ZDActivityMoreChioceModel *model;

@property (nonatomic, weak) id<ZDActivityMoreChioceCellDelegate> moreChioceCellDelegate;

@end

NS_ASSUME_NONNULL_END
