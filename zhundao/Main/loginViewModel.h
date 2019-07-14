//
//  loginViewModel.h
//  zhundao
//
//  Created by xhkj on 2018/4/16.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginViewModel : NSObject

/*! 账号密码登录后获取token */
+ (void)getTokenByAccount:(NSString *)phoneStr passWord:(NSString *)password ;
/**
 微信登录后获取token
 
 */
+ (void)getTokenByWechat:(NSString *)code;
@end
