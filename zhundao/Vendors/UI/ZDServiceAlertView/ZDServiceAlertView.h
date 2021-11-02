//
//  ZDServiceAlertView.h
//  zhundao
//
//  Created by maj on 2020/1/13.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class ZDServiceAlertView;
@protocol ZDServiceAlertViewDelegate <NSObject>
- (void)alertView:(ZDServiceAlertView *)alertView didTapUrl:(NSString *)url title:(NSString *)title;

@end

@interface ZDServiceAlertView : UIView

@property (nonatomic, weak) id<ZDServiceAlertViewDelegate> alertViewDelegate;
// 标题
@property (nonatomic, copy) NSString *title;
// 标题颜色  default blackColor
@property (nonatomic, strong) UIColor *titleColor;
// 标题字体 default ZDMediumFont(25)
@property (nonatomic, strong) UIFont *titleFont;
// 文本对齐 default NSTextAlignmentLeft
@property (nonatomic, assign) NSTextAlignment textViewAlignment;
// 内容
@property (nonatomic, copy) NSString *content;
// 富文本内容
@property (nonatomic, copy) NSAttributedString *attributeContent;
// 富文本链接的样式
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey,id> *linkTextAttributes;

- (instancetype)initWithCancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock;

- (void)animationIn;
- (void)animationOut;


@end

NS_ASSUME_NONNULL_END
