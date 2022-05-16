//
//  ZDActivityMoreChioceSuccessCell.h
//  zhundao
//
//  Created by huanfutech on 2022/5/12.
//  Copyright © 2022 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDActivityMoreChioceSuccessCell;
@protocol ZDActivityMoreChioceSuccessCellDelegate <NSObject>

- (void)ZDActivityMoreChioceSuccessCellSelectImage:(ZDActivityMoreChioceSuccessCell *)successCell;

@end

@interface ZDActivityMoreChioceSuccessCell : UITableViewCell
@property (nonatomic, strong) ZDActivityADModel *adModel;
@property (nonatomic, weak) id<ZDActivityMoreChioceSuccessCellDelegate> activityMoreChioceSuccessCellDelegate;

@end

NS_ASSUME_NONNULL_END
