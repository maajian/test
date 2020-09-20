//
//  PGMeMyWalletView.h
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PGMeMyWalletDelegate <NSObject>
/*! 提现 */
- (void)gotoWithDraw ;
/*! 明细 */
- (void)showDetail;
/*! 返回 */
- (void)popBack;
/*! 支付密码设置 */
- (void)setPassword;
/*! 常见问题 */
- (void)normalQuestion;
/*! 前往认证 */
- (void)gotoAuth;

@end


@interface PGMeMyWalletView : UIView
/*! 初始化视图 */
- (instancetype)initInView :(UIView *)view;
/*! 钱的数量label   在.h中提供修改*/
@property(nonatomic,strong)UILabel *moneyLabel ;
/*! 提现按钮 */
@property(nonatomic,strong)UIButton *withdrawButton ;
/*! 回调提现 */
@property(nonatomic,weak) id<PGMeMyWalletDelegate>delegate;

@end
