//
//  ZDLoginCodeSendView.h
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDLoginCodeSendView;
@protocol ZDLoginCodeSendViewDelegate <NSObject>
// 关闭
- (void)ZDLoginCodeSendView:(ZDLoginCodeSendView *)loginCodeSendView didTapCloseButton:(UIButton *)button;
// next
- (void)ZDLoginCodeSendView:(ZDLoginCodeSendView *)loginCodeSendView didTapNextButton:(UIButton *)button;

@end

@interface ZDLoginCodeSendView : UIView

@property (nonatomic, strong, readonly) UITextField   *phoneTF;
@property (nonatomic, weak) id<ZDLoginCodeSendViewDelegate> loginCodeSendViewDelegate;

@end

NS_ASSUME_NONNULL_END
