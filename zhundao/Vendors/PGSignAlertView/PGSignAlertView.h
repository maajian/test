//
//  PGSignAlertView.h
//  zhundao
//
//  Created by maj on 2019/12/5.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGSignAlertView : UIView

/**
 初始化

 @param cancelTitle 取消标题
 @param sureTitle 确定标题
 @param titleColor 标题颜色
 @param messageTitle 内容
 @param title 标题
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 @return PGSignAlertView
 */
+ (instancetype)alertWithTitle:(NSString *)title titleColor:(UIColor *)titleColor messageTitle:(NSString *)messageTitle cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle cancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock;

@property (nonatomic, assign) NSTextAlignment messageAlignment;

@end

NS_ASSUME_NONNULL_END
