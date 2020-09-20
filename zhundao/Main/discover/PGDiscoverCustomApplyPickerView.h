//
//  PGDiscoverCustomApplyPickerView.h
//  zhundao
//
//  Created by maj on 2019/5/18.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGDiscoverCustomApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PGDiscoverCustomApplyPickerView;

@protocol PGDiscoverCustomApplyPickerViewDelegate <NSObject>
// 选中
- (void)customApplyPickerView:(PGDiscoverCustomApplyPickerView *)customApplyPickerView didSelectType:(ZDCustomType)customType;

@end

@interface PGDiscoverCustomApplyPickerView : UIView

@property (nonatomic, weak) id<PGDiscoverCustomApplyPickerViewDelegate> customApplyPickerViewDelegate;

- (void)show;

@end

NS_ASSUME_NONNULL_END
