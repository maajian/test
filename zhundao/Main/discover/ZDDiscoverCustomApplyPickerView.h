//
//  ZDDiscoverCustomApplyPickerView.h
//  zhundao
//
//  Created by maj on 2019/5/18.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDDiscoverCustomApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDDiscoverCustomApplyPickerView;

@protocol ZDDiscoverCustomApplyPickerViewDelegate <NSObject>
// 选中
- (void)customApplyPickerView:(ZDDiscoverCustomApplyPickerView *)customApplyPickerView didSelectType:(ZDCustomType)customType;

@end

@interface ZDDiscoverCustomApplyPickerView : UIView

@property (nonatomic, weak) id<ZDDiscoverCustomApplyPickerViewDelegate> customApplyPickerViewDelegate;

- (void)show;

@end

NS_ASSUME_NONNULL_END
