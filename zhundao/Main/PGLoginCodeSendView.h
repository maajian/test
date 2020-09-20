//
//  PGLoginCodeSendView.h
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGLoginCodeSendView;
@protocol PGLoginCodeSendViewDelegate <NSObject>
// 关闭
- (void)PGLoginCodeSendView:(PGLoginCodeSendView *)loginCodeSendView didTapCloseButton:(UIButton *)button;
// next
- (void)PGLoginCodeSendView:(PGLoginCodeSendView *)loginCodeSendView didTapNextButton:(UIButton *)button;

@end

@interface PGLoginCodeSendView : UIView

@property (nonatomic, strong, readonly) UITextField   *phoneTF;
@property (nonatomic, weak) id<PGLoginCodeSendViewDelegate> loginCodeSendViewDelegate;

@end

NS_ASSUME_NONNULL_END
