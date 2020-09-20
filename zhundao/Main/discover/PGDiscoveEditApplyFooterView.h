//
//  PGDiscoveEditApplyFooterView.h
//  zhundao
//
//  Created by maj on 2018/12/4.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PGDiscoveEditApplyFooterViewDelegate <NSObject>
// 点击增加选项
- (void)footerView:(UIView *)footerView didAddButton:(UIButton *)button;

@end

@interface PGDiscoveEditApplyFooterView : UIView
// 代理
@property (nonatomic, weak) id<PGDiscoveEditApplyFooterViewDelegate> discoveEditApplyFooterViewDelegate;
// 是否删除增加选项
@property (nonatomic, assign) BOOL isNeedChoice;
// 是否新增
@property (nonatomic, assign) BOOL isNew;

@end

NS_ASSUME_NONNULL_END
