//
//  PGLoginInfoEditVC.h
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGBaseVC.h"

@interface PGLoginInfoEditVC : PGBaseVC
 // 手机号码 
@property (nonatomic, copy) NSString *phoneStr;
 // 验证码
@property (nonatomic, copy) NSString *code;

@end
