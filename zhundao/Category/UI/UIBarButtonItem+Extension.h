//
//  UIBarButtonItem+Extension.h
//  zhundao
//
//  Created by maj on 2019/5/25.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)
#pragma mark --- 图片
// 返回
+ (UIBarButtonItem *)backImageItemWithTarget:(id)target action:(SEL)action;
// 添加
+ (UIBarButtonItem *)addWhiteImageItemWithTarget:(id)target action:(SEL)action;
// 活动添加
+ (UIBarButtonItem *)activityAddItemWithTarget:(id)target action:(SEL)action;
// 扫一扫
+ (UIBarButtonItem *)scanItemWithTarget:(id)target action:(SEL)action;
// 分享
+ (UIBarButtonItem *)shareItemWithTarget:(id)target action:(SEL)action;
// 更多
+ (UIBarButtonItem *)moreItemWithTarget:(id)target action:(SEL)action;

#pragma mark --- 文字
// 保存
+ (UIBarButtonItem *)saveTextItemWithTarget:(id)target action:(SEL)action ;
// 清除未读
+ (UIBarButtonItem *)clearReadTextItemWithTarget:(id)target action:(SEL)action;
// 返回
+ (UIBarButtonItem *)cancelTextItemWithTarget:(id)target action:(SEL)action;
// 保存
+ (UIBarButtonItem *)saveText2ItemWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
