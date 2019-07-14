//
//  AllAccountModel.m
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AllAccountModel.h"

@implementation AllAccountModel

- (instancetype)initWithAccount:(NSString *)account bankName:(NSString *)bankName iD:(NSInteger)iD {
    if (self = [super init]) {
        self.Account = account;
        self.BankName = bankName;
        self.ID = iD;
    }
    return self;
}

@end
