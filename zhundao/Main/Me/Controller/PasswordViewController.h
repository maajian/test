//
//  PasswordViewController.h
//  zhundao
//
//  Created by zhundao on 2017/11/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Old, //提现输入老密码
    New, //提示输入新密码
    ReNew, //提示再次输入新密码
} payState;


@interface PasswordViewController : BaseViewController

@property(nonatomic,assign)payState state;
/*! 密码 */
@property(nonatomic,copy)NSString *password;

@end
