//
//  ZDCodeLoginViewModel.h
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDCodeLoginViewModel : UIView
 // 发送验证码
@property (nonatomic, strong) NSDictionary *sendCodeJson;

/**
 发送验证码
 
 @param phoneStr 电话号码
 @param successBlock <#successBlock description#>
 @param failBlock <#failBlock description#>
 */
- (void)sendCode:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock;


// 验证码登录
- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock ;

@end
