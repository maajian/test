//
//  CodeLoginView.h
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodeLoginViewDelegate<NSObject>
 // 返回
- (void)backLogin;
 // 发送验证码
- (void)codeLoginView:(UIView *)codeLoginView phoneStr:(NSString *)phoneStr;
 // 无法获取验证码
- (void)goCodeWeb;
 // 验证码登录
- (void)loginWithPhoneStr:(NSString *)phoneStr code:(NSString *)code;

@end

@interface CodeLoginView : UIView
 // 代理
@property (nonatomic, weak) id<CodeLoginViewDelegate> codeLoginViewDelegate;

@end
