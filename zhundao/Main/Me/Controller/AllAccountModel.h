//
//  AllAccountModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllAccountModel : NSObject
/*! 账户 */
@property(nonatomic,copy)NSString *Account;
/*! 账户名称 */
@property(nonatomic,copy)NSString *BankName;
/*! 账号ID */
@property(nonatomic,assign)NSInteger ID;

- (instancetype)initWithAccount:(NSString *)account bankName:(NSString *)bankName iD:(NSInteger)iD;

@end
