//
//  ZDServiceAlertView.h
//  zhundao
//
//  Created by maj on 2020/1/13.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZDServiceAlertViewDismissType) {
    ZDServiceAlertViewDismissTypeAnimation = 0, // 透明度变化
    ZDServiceAlertViewDismissTypeDirect, // 直接退出
};

typedef NS_ENUM(NSInteger, ZDServiceAlertViewType) {
    ZDServiceAlertViewTypePrivacyNormalAlert,
    ZDServiceAlertViewTypePrivacyNeedCheck,
};

@class ZDServiceAlertView;
@protocol ZDServiceAlertViewDelegate <NSObject>
- (void)alertView:(ZDServiceAlertView *)alertView didTapUrl:(NSString *)url;
- (void)alertView:(ZDServiceAlertView *)alertView didTapCancelButton:(UIButton *)button;
- (void)alertView:(ZDServiceAlertView *)alertView didTapSureButton:(UIButton *)button;

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
// 取消按钮标题 default "取消"
@property (nonatomic, strong) NSString *cancelTitle;
// 确定按钮标题 default "确定"
@property (nonatomic, strong) NSString *sureTitle;
// 只有一个按钮显示
@property (nonatomic, assign) BOOL onlyOneButton;
// 取消按钮消失动画
@property (nonatomic, assign) ZDServiceAlertViewDismissType cancelDismissType;
// 确定按钮消失动画
@property (nonatomic, assign) ZDServiceAlertViewDismissType sureDismissType;
// 类型
@property (nonatomic, assign) ZDServiceAlertViewType alertViewType;

- (instancetype)initWithCancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock;

- (void)animationIn;
- (void)animationOut;
- (void)contentIn;
- (void)contentOut;


@end

NS_ASSUME_NONNULL_END
