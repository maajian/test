//
//  PGActivityIsReadView.h
//  zhundao
//
//  Created by zhundao on 2017/8/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol readDelegate <NSObject>

- (void)cancelSend;

- (void)nextStep;

@end

@interface PGActivityIsReadView : UIView

@property(nonatomic,weak) id<readDelegate>  readDelegate;

/*! 下一步按钮 */
@property(nonatomic,strong)UIButton *nextStepButton;
/*! 取消按钮 */
@property(nonatomic,strong)UIButton *cancelButton;

///*! 弹出动画 */
//- (void)fadeUp ;
///*! 收回动画 */
//- (void)fadeOut;


@end
