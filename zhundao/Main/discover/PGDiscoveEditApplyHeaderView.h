//
//  PGDiscoveEditApplyHeaderView.h
//  zhundao
//
//  Created by maj on 2018/12/4.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGDiscoverCustomApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PGDiscoveEditApplyHeaderView;

@protocol PGDiscoveEditApplyHeaderViewDelegate <NSObject>
// 改变类型
- (void)headerView:(PGDiscoveEditApplyHeaderView *)headerView didChangeType:(UILabel *)typeLabel;

@end

@interface PGDiscoveEditApplyHeaderView : UIView
// 标题
@property (nonatomic, strong, readonly) UITextField *titleTF;
// 开关
@property (nonatomic, strong, readonly) UISwitch *mustSwitch;
// 类型的文字
@property (nonatomic, strong, readonly) UILabel *typeLabel;
// 填写提示输入框
@property (nonatomic, strong, readonly) UITextField *tipInputTF;


// 数据
@property (nonatomic, strong) PGDiscoverCustomApplyModel *model;
// 代理
@property (nonatomic, weak) id<PGDiscoveEditApplyHeaderViewDelegate> discoveEditApplyHeaderViewDelegate;

@end

NS_ASSUME_NONNULL_END
