//
//  ZDAlertView.h
//  PBimming
//
//  Created by 罗程勇 on 2018/1/2.
//  Copyright © 2018年 鱼动科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDAlertView : UIView
 // 取消block
@property (nonatomic, copy) dispatch_block_t cancelBlock;
 // 确定block
@property (nonatomic, copy) dispatch_block_t sureBlock;

#pragma mark --- 初始化
/**
 类方法初始化
 
 @param title 标题
 @param message 副标题
 @param cancelBlock 取消点击事件
 @param sureBlock 确定点击事件
 @return ZDAlertView
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message sureBlock:(dispatch_block_t)sureBlock cancelBlock:(dispatch_block_t)cancelBlock;
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(dispatch_block_t)cancelBlock;

/**
 初始化
 
 @param title 标题
 @param message 副标题
 @param cancelTitle 取消标题
  @param sureTitle  确定标题
 @param cancelBlock 取消点击事件
 @param sureBlock 确定点击事件
 @return ZDAlertView
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle sureBlock:(dispatch_block_t)sureBlock cancelBlock:(dispatch_block_t)cancelBlock;

/**
 实例方法初始化

 @param title 标题
 @param message 副标题
 @param cancelButtonTitle 取消按钮标题
 @param sureButtonTitle 确定按钮标题
 @param cancelBlock 取消事件
 @param sureBlock 确定事件
 @return ZDAlertView
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle cancelBlock:(dispatch_block_t)cancelBlock sureBlock:(dispatch_block_t)sureBlock;

// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 副标题
@property (nonatomic, strong) UILabel *messageLabel;
// 内容视图
@property (nonatomic, strong) UIView *contentView;

- (void)fadeOut;

@end
